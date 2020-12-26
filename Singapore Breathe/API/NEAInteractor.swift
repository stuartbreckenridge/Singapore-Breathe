//
//  NEAInteractor.swift
//  Singapore Breathe
//
//  Created by Stuart Breckenridge on 26/12/2020.
//

import Foundation
import Combine

public final class NEAInteractor: ObservableObject {
    
    @Published public var combinedPublisher = PassthroughSubject<AirQuality, Error>()
    
    public static let shared = NEAInteractor()
    private init () {}
    
    public func getLatestMetadataReading() {
        var latestPM25: PM25!
        var latestPSI: PSI!
        
        getLatestPSI { [weak self] (psi, error) in
            if let err = error {
                self?.combinedPublisher.send(completion: Subscribers.Completion<Error>.failure(err))
                return
            } else {
                latestPSI = psi
                self?.getLatestPM25 { [weak self] (pm25, error) in
                    if let err = error {
                        self?.combinedPublisher.send(completion: Subscribers.Completion<Error>.failure(err))
                        return
                    } else {
                        latestPM25 = pm25
                        self?.combineLatestData(latestPSI, pm25: latestPM25)
                    }
                }
            }
        }
    }
    
    private func getLatestPSI(completion: @escaping (PSI?, Error?) -> ()) {
        let task = URLSession.shared.dataTask(with: URLRequest(url: Endpoints.psi.url), completionHandler: { data, response, error in
            guard let receivedData = data else {
                completion(nil, APIError.noData)
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
    
    private func getLatestPM25(completion: @escaping (PM25?, Error?) -> ()) {
        let task = URLSession.shared.dataTask(with: URLRequest(url: Endpoints.pm25.url), completionHandler: { data, response, error in
            guard let receivedData = data else {
                completion(nil, APIError.noData)
                return
            }
            do {
                let pm25 = try JSONDecoder().decode(PM25.self, from: receivedData)
                completion(pm25, nil)
            } catch {
                completion(nil, APIError.other(error))
                return
            }
            
        })
        task.resume()
    }
    
    private func combineLatestData(_ psi: PSI, pm25: PM25) {
        let regions = ["north", "east", "south", "west", "central", "national"]
        let combinedMetadata = regions.map { region in
            CombinedRegionMetadatum(name: region.capitalized,
                                    location: psi.regionMetadata.filter { $0.name == region }.first!.labelLocation,
                                    pm25Hourly: pm25.items.map { $0.readings.pm25OneHourly[dynamicMember: region] }.first ?? 0 ,
                                    psiHourly: psi[dynamicMember:region],
                                    timeStamp: psi.items.map { $0.timestamp }.first ?? "",
                                    updatedTimeStamp: psi.items.map { $0.updateTimestamp }.first ?? "")
        }
        combinedPublisher.send(AirQuality(combinedRegionMetadatum: combinedMetadata))
    }
    
    
    
}
