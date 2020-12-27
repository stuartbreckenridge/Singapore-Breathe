//
//  AirQualityViewModel.swift
//  Singapore Breathe
//
//  Created by Stuart Breckenridge on 27/12/2020.
//

import Foundation
import Combine
import MapKit

public final class AirQualityViewModel: ObservableObject {
    
    public let api = APIInteractor.shared
    @Published public private(set) var apiError: Error? {
        didSet {
            apiError != nil ? (showError = true) : (showError = false)
        }
    }
    @Published public private(set) var latestPSI: PSI?
    @Published public var showError: Bool = false
    
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
            } receiveValue: { (psi) in
                self.latestPSI = psi
            }
            .store(in: &bag)
    }
    
}
