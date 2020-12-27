//
//  AirQualityViewModel.swift
//  Singapore Breathe
//
//  Created by Stuart Breckenridge on 27/12/2020.
//

import Foundation
import Combine

public final class AirQualityViewModel: ObservableObject {
    
    public let api = NEAInteractor.shared
    @Published public private(set) var apiError: Error?
    @Published public private(set) var airQuality: AirQuality = AirQuality(combinedRegionMetadatum: [])
    
    private var bag = Set<AnyCancellable>()
    
    init() {
        api
            .combinedPublisher
            .receive(on: OperationQueue.main)
            .sink { (error) in
                switch error {
                case .failure(let err):
                    self.apiError = err
                case .finished:
                    print("Finished")
                }
            } receiveValue: { (airQuality) in
                self.airQuality = airQuality
            }
            .store(in: &bag)
    }
    
    
}
