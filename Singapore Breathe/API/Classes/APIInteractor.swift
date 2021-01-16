//
//  APIInteractor.swift
//  Singapore Breathe
//
//  Created by Stuart Breckenridge on 26/12/2020.
//

import Foundation
import Combine
import CoreLocation

public final class APIInteractor: ObservableObject {
    
    //@Published public private(set) var latestRegionalReadings = [RegionalAQM]()
    @Published public private(set) var apiError: APIError? = nil
    
    public static let shared = APIInteractor()
    private init () {}
    
    public func getLatestMetadataReading() {
        var latestPM25: PSI!
        var latestPSI: PSI!
        
        getLatestPSI { [weak self] (psi, error) in
            if let err = error {
                self?.apiError = .other(err)
                return
            } else {
                latestPSI = psi
                self?.getLatestPM25 { [weak self] (pm25, error) in
                    if let err = error {
                        self?.apiError = .other(err)
                        return
                    } else {
                        latestPM25 = pm25
                        self?.combineLatestData(latestPSI, pm25: latestPM25)
                    }
                }
            }
        }
    }
    
    private func getLatestPSI(completion: @escaping (PSI?, Error?) -> Void) {
        var comps = URLComponents(url: Endpoints.psi.url, resolvingAgainstBaseURL: false)
        comps?.queryItems = [URLQueryItem(name: "date_time", value: currentDateTime())]
        
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: comps!.url!), completionHandler: { data, response, error in
            guard let receivedData = data else {
                completion(nil, APIError.noData)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200..<299).contains(httpResponse.statusCode) else {
                completion(nil, APIError.invalidResponse((response as! HTTPURLResponse).statusCode))
                return
            }
            
            do {
                let psi = try JSONDecoder().decode(PSI.self, from: receivedData)
                completion(psi, nil)
            } catch {
                completion(nil, APIError.other(error))
                return
            }
            
        })
        task.resume()
    }
    
    private func getLatestPM25(completion: @escaping (PSI?, Error?) -> Void) {
        var comps = URLComponents(url: Endpoints.pm25.url, resolvingAgainstBaseURL: false)
        comps?.queryItems = [URLQueryItem(name: "date_time", value: currentDateTime())]
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: comps!.url!), completionHandler: { data, response, error in
            guard let receivedData = data else {
                completion(nil, APIError.noData)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  (200..<299).contains(httpResponse.statusCode) else {
                completion(nil, APIError.invalidResponse((response as! HTTPURLResponse).statusCode))
                return
            }
            do {
                let pm25 = try JSONDecoder().decode(PSI.self, from: receivedData)
                completion(pm25, nil)
            } catch {
                completion(nil, APIError.other(error))
                return
            }
        })
        task.resume()
    }
    
    private func combineLatestData(_ psi: PSI, pm25: PSI) {
        
        /* Create Regional Data */
        let regions = psi.regionMetadata.compactMap { $0.name }
        
        // Check there's data
        guard psi.items.count > 0,
              psi.items.first?.timestamp != nil,
              psi.items.first?.updateTimestamp != nil,
              pm25.items.count > 0,
              pm25.items.first?.timestamp != nil,
              pm25.items.first?.updateTimestamp != nil else {
            return
        }
        
        for region in regions {
            let aqm = RegionalAQM(context: PersistenceController.shared.container.viewContext)
            aqm.region = region
            psi.items.first.map { item in
                aqm.timestamp = apiDateStringToDate(item.timestamp!)
                aqm.updatedTimestamp = apiDateStringToDate(item.updateTimestamp!)
                aqm.id = region + "_" + item.timestamp!
                if region == "north" {
                    let label = psi.regionMetadata.filter { $0.name == region }.first!
                    aqm.latitude = label.labelLocation!.latitude
                    aqm.longitude = label.labelLocation!.longitude
                    aqm.co_eight_hour_max = item.readings!["co_eight_hour_max"]!.north ?? 0.0
                    aqm.co_sub_index = item.readings!["co_sub_index"]!.north ?? 0.0
                    aqm.no2_one_hour_max = item.readings!["no2_one_hour_max"]!.north ?? 0.0
                    aqm.o3_eight_hour_max = item.readings!["o3_eight_hour_max"]!.north ?? 0.0
                    aqm.o3_sub_index = item.readings!["o3_sub_index"]!.north ?? 0.0
                    aqm.pm10_sub_index = item.readings!["pm10_sub_index"]!.north ?? 0.0
                    aqm.pm10_twenty_four_hourly = item.readings!["pm10_twenty_four_hourly"]!.north ?? 0.0
                    aqm.pm25_one_hourly = pm25.items.first!.readings!["pm25_one_hourly"]?.north ?? 0.0
                    aqm.pm25_sub_index = item.readings!["pm25_sub_index"]!.north ?? 0.0
                    aqm.pm25_twenty_four_hourly = item.readings!["pm25_twenty_four_hourly"]!.north ?? 0.0
                    aqm.psi_twenty_four_hourly = item.readings!["psi_twenty_four_hourly"]!.north ?? 0.0
                    aqm.so2_sub_index = item.readings!["so2_sub_index"]!.north ?? 0.0
                    aqm.so2_twenty_four_hourly = item.readings!["so2_twenty_four_hourly"]!.north ?? 0.0
                }
                if region == "east" {
                    let label = psi.regionMetadata.filter { $0.name == region }.first!
                    aqm.latitude = label.labelLocation!.latitude
                    aqm.longitude = label.labelLocation!.longitude
                    aqm.co_eight_hour_max = item.readings!["co_eight_hour_max"]!.east ?? 0.0
                    aqm.co_sub_index = item.readings!["co_sub_index"]!.east ?? 0.0
                    aqm.no2_one_hour_max = item.readings!["no2_one_hour_max"]!.east ?? 0.0
                    aqm.o3_eight_hour_max = item.readings!["o3_eight_hour_max"]!.east ?? 0.0
                    aqm.o3_sub_index = item.readings!["o3_sub_index"]!.east ?? 0.0
                    aqm.pm10_sub_index = item.readings!["pm10_sub_index"]!.east ?? 0.0
                    aqm.pm10_twenty_four_hourly = item.readings!["pm10_twenty_four_hourly"]!.east ?? 0.0
                    aqm.pm25_one_hourly = pm25.items.first!.readings!["pm25_one_hourly"]?.east ?? 0.0
                    aqm.pm25_sub_index = item.readings!["pm25_sub_index"]!.east ?? 0.0
                    aqm.pm25_twenty_four_hourly = item.readings!["pm25_twenty_four_hourly"]!.east ?? 0.0
                    aqm.psi_twenty_four_hourly = item.readings!["psi_twenty_four_hourly"]!.east ?? 0.0
                    aqm.so2_sub_index = item.readings!["so2_sub_index"]!.east ?? 0.0
                    aqm.so2_twenty_four_hourly = item.readings!["so2_twenty_four_hourly"]!.east ?? 0.0
                }
                if region == "south" {
                    let label = psi.regionMetadata.filter { $0.name == region }.first!
                    aqm.latitude = label.labelLocation!.latitude
                    aqm.longitude = label.labelLocation!.longitude
                    aqm.co_eight_hour_max = item.readings!["co_eight_hour_max"]!.south ?? 0.0
                    aqm.co_sub_index = item.readings!["co_sub_index"]!.south ?? 0.0
                    aqm.no2_one_hour_max = item.readings!["no2_one_hour_max"]!.south ?? 0.0
                    aqm.o3_eight_hour_max = item.readings!["o3_eight_hour_max"]!.south ?? 0.0
                    aqm.o3_sub_index = item.readings!["o3_sub_index"]!.south ?? 0.0
                    aqm.pm10_sub_index = item.readings!["pm10_sub_index"]!.south ?? 0.0
                    aqm.pm10_twenty_four_hourly = item.readings!["pm10_twenty_four_hourly"]!.south ?? 0.0
                    aqm.pm25_one_hourly = pm25.items.first!.readings!["pm25_one_hourly"]?.south ?? 0.0
                    aqm.pm25_sub_index = item.readings!["pm25_sub_index"]!.south ?? 0.0
                    aqm.pm25_twenty_four_hourly = item.readings!["pm25_twenty_four_hourly"]!.south ?? 0.0
                    aqm.psi_twenty_four_hourly = item.readings!["psi_twenty_four_hourly"]!.south ?? 0.0
                    aqm.so2_sub_index = item.readings!["so2_sub_index"]!.south ?? 0.0
                    aqm.so2_twenty_four_hourly = item.readings!["so2_twenty_four_hourly"]!.south ?? 0.0
                }
                if region == "west" {
                    let label = psi.regionMetadata.filter { $0.name == region }.first!
                    aqm.latitude = label.labelLocation!.latitude
                    aqm.longitude = label.labelLocation!.longitude
                    aqm.co_eight_hour_max = item.readings!["co_eight_hour_max"]!.west ?? 0.0
                    aqm.co_sub_index = item.readings!["co_sub_index"]!.west ?? 0.0
                    aqm.no2_one_hour_max = item.readings!["no2_one_hour_max"]!.west ?? 0.0
                    aqm.o3_eight_hour_max = item.readings!["o3_eight_hour_max"]!.west ?? 0.0
                    aqm.o3_sub_index = item.readings!["o3_sub_index"]!.west ?? 0.0
                    aqm.pm10_sub_index = item.readings!["pm10_sub_index"]!.west ?? 0.0
                    aqm.pm10_twenty_four_hourly = item.readings!["pm10_twenty_four_hourly"]!.west ?? 0.0
                    aqm.pm25_one_hourly = pm25.items.first!.readings!["pm25_one_hourly"]?.west ?? 0.0
                    aqm.pm25_sub_index = item.readings!["pm25_sub_index"]!.west ?? 0.0
                    aqm.pm25_twenty_four_hourly = item.readings!["pm25_twenty_four_hourly"]!.west ?? 0.0
                    aqm.psi_twenty_four_hourly = item.readings!["psi_twenty_four_hourly"]!.west ?? 0.0
                    aqm.so2_sub_index = item.readings!["so2_sub_index"]!.west ?? 0.0
                    aqm.so2_twenty_four_hourly = item.readings!["so2_twenty_four_hourly"]!.west ?? 0.0
                }
                if region == "central" {
                    let label = psi.regionMetadata.filter { $0.name == region }.first!
                    aqm.latitude = label.labelLocation!.latitude
                    aqm.longitude = label.labelLocation!.longitude
                    aqm.co_eight_hour_max = item.readings!["co_eight_hour_max"]!.central ?? 0.0
                    aqm.co_sub_index = item.readings!["co_sub_index"]!.central ?? 0.0
                    aqm.no2_one_hour_max = item.readings!["no2_one_hour_max"]!.central ?? 0.0
                    aqm.o3_eight_hour_max = item.readings!["o3_eight_hour_max"]!.central ?? 0.0
                    aqm.o3_sub_index = item.readings!["o3_sub_index"]!.central ?? 0.0
                    aqm.pm10_sub_index = item.readings!["pm10_sub_index"]!.central ?? 0.0
                    aqm.pm10_twenty_four_hourly = item.readings!["pm10_twenty_four_hourly"]!.central ?? 0.0
                    aqm.pm25_one_hourly = pm25.items.first!.readings!["pm25_one_hourly"]?.central ?? 0.0
                    aqm.pm25_sub_index = item.readings!["pm25_sub_index"]!.central ?? 0.0
                    aqm.pm25_twenty_four_hourly = item.readings!["pm25_twenty_four_hourly"]!.central ?? 0.0
                    aqm.psi_twenty_four_hourly = item.readings!["psi_twenty_four_hourly"]!.central ?? 0.0
                    aqm.so2_sub_index = item.readings!["so2_sub_index"]!.central ?? 0.0
                    aqm.so2_twenty_four_hourly = item.readings!["so2_twenty_four_hourly"]!.central ?? 0.0
                }
                if region == "national" {
                    let label = psi.regionMetadata.filter { $0.name == region }.first!
                    aqm.latitude = label.labelLocation!.latitude
                    aqm.longitude = label.labelLocation!.longitude
                    aqm.co_eight_hour_max = item.readings!["co_eight_hour_max"]!.national ?? 0.0
                    aqm.co_sub_index = item.readings!["co_sub_index"]!.national ?? 0.0
                    aqm.no2_one_hour_max = item.readings!["no2_one_hour_max"]!.national ?? 0.0
                    aqm.o3_eight_hour_max = item.readings!["o3_eight_hour_max"]!.national ?? 0.0
                    aqm.o3_sub_index = item.readings!["o3_sub_index"]!.national ?? 0.0
                    aqm.pm10_sub_index = item.readings!["pm10_sub_index"]!.national ?? 0.0
                    aqm.pm10_twenty_four_hourly = item.readings!["pm10_twenty_four_hourly"]!.national ?? 0.0
                    aqm.pm25_one_hourly = pm25.items.first!.readings!["pm25_one_hourly"]?.national ?? 0.0
                    aqm.pm25_sub_index = item.readings!["pm25_sub_index"]!.national ?? 0.0
                    aqm.pm25_twenty_four_hourly = item.readings!["pm25_twenty_four_hourly"]!.national ?? 0.0
                    aqm.psi_twenty_four_hourly = item.readings!["psi_twenty_four_hourly"]!.national ?? 0.0
                    aqm.so2_sub_index = item.readings!["so2_sub_index"]!.national ?? 0.0
                    aqm.so2_twenty_four_hourly = item.readings!["so2_twenty_four_hourly"]!.national ?? 0.0
                }
            }
        }
        
        do {
            if PersistenceController.shared.container.viewContext.hasChanges {
                try PersistenceController.shared.container.viewContext.save()
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    public func currentDateTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Singapore")
        return dateFormatter.string(from: Date())
    }
    
    public func apiDateStringToDate(_ dateString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Singapore")
        let date = dateFormatter.date(from: dateString)!
        
        let sqliteFormatter = DateFormatter()
        sqliteFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        sqliteFormatter.timeZone = TimeZone(identifier: "Asia/Singapore")
        let str = sqliteFormatter.string(from: date)
        return sqliteFormatter.date(from: str)!
    }
    
}
