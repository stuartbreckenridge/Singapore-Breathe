//
//  NEAInteractor.swift
//  Singapore Breathe
//
//  Created by Stuart Breckenridge on 26/12/2020.
//

import Foundation
import Combine

public final class NEAInteractor: ObservableObject {
    
    @Published public var combinedPublisher = PassthroughSubject<PSI, Error>()
    
    public static let shared = NEAInteractor()
    private init () {}
    
    public func getLatestMetadataReading() {
        var latestPM25: PSI!
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
        var comps = URLComponents(url: Endpoints.psi.url, resolvingAgainstBaseURL: false)
        comps?.queryItems = [URLQueryItem(name: "date_time", value: currentDateTime())]
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: comps!.url!), completionHandler: { data, response, error in
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
    
    private func getLatestPM25(completion: @escaping (PSI?, Error?) -> ()) {
        var comps = URLComponents(url: Endpoints.pm25.url, resolvingAgainstBaseURL: false)
        comps?.queryItems = [URLQueryItem(name: "date_time", value: currentDateTime())]
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: comps!.url!), completionHandler: { data, response, error in
            guard let receivedData = data else {
                completion(nil, APIError.noData)
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
        var combinedPSI = psi
        combinedPSI.items.insert(pm25.items.first!, at: combinedPSI.items.count)
        combinedPublisher.send(combinedPSI)
    }
    
    public func currentDateTime() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Singapore")
        
        return dateFormatter.string(from: Date())
        
    }
    
}
