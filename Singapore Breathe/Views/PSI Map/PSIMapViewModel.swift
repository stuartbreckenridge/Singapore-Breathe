//
//  PSIMapViewModel.swift
//  Singapore Breathe
//
//  Created by Stuart Breckenridge on 27/12/2020.
//

import Foundation
import Combine
import MapKit
import SwiftUI


public final class PSIMapViewModel: ObservableObject {
    
    public let api = APIInteractor.shared
    @Published public private(set) var apiError: Error? {
        didSet {
            apiError != nil ? (showError = true) : (showError = false)
        }
    }
    @Published public var showError: Bool = false
    @Published public var latestPSIData = [PSIAnnotationData]()
    @Published public var showDetailsSheet: Bool = false
    @Published public var selectedPSIAnnotationData: PSIAnnotationData? {
        didSet {
            selectedPSIAnnotationData == nil ? (showPSICard = false) : (showPSICard = true)
        }
    }
    @Published public var showPSICard: Bool = false
    
    
    private var bag = Set<AnyCancellable>()
    
    init() {
        api.$apiError.receive(on: OperationQueue.main).sink { [weak self] (error) in
            self?.apiError = error
        }.store(in: &bag)
        
        api.$latestRegionalReadings.receive(on: OperationQueue.main).sink(receiveValue: { [weak self] values in
            guard let self = self else { return }
            self.prepareAnnotationData(regionalAQMReadings: self.api.latestRegionalReadings)
        }).store(in: &bag)
    }
    
}

private extension PSIMapViewModel {
    
    func prepareAnnotationData(regionalAQMReadings: [RegionalAQM]) {
        var annotations = [PSIAnnotationData]()
        for aqm in regionalAQMReadings {
            annotations.append(PSIAnnotationData(name: aqm.region!.capitalized,
                                                    location: LabelLocation(latitude: aqm.latitude, longitude: aqm.longitude),
                                                    timestamp: aqm.timestamp!,
                                                    updatedTimestamp: aqm.updatedTimestamp!,
                                                    co_eight_hour_max: aqm.co_eight_hour_max,
                                                    co_sub_index: aqm.co_sub_index,
                                                    no2_one_hour_max: aqm.no2_one_hour_max,
                                                    o3_eight_hour_max: aqm.o3_eight_hour_max,
                                                    o3_sub_index: aqm.o3_sub_index,
                                                    pm10_sub_index: aqm.pm10_sub_index,
                                                    pm10_twenty_four_hourly: aqm.pm10_twenty_four_hourly,
                                                    pm25_one_hourly: aqm.pm25_one_hourly,
                                                    pm25_sub_index: aqm.pm25_sub_index,
                                                    pm25_twenty_four_hourly: aqm.pm25_twenty_four_hourly,
                                                    psi_twenty_four_hourly: aqm.psi_twenty_four_hourly,
                                                    so2_sub_index: aqm.so2_sub_index,
                                                    so2_twenty_four_hourly: aqm.so2_twenty_four_hourly))
        }
        latestPSIData = annotations
    }
    
}

public struct PSIAnnotationData: Identifiable {
    
    public var id: String { name }
    public var name: String
    public var location: LabelLocation
    public var timestamp: Date
    public var updatedTimestamp: Date
    public var co_eight_hour_max: Double
    public var co_sub_index: Double
    public var no2_one_hour_max: Double
    public var o3_eight_hour_max: Double
    public var o3_sub_index: Double
    public var pm10_sub_index: Double
    public var pm10_twenty_four_hourly: Double
    public var pm25_one_hourly: Double
    public var pm25_sub_index: Double
    public var pm25_twenty_four_hourly: Double
    public var psi_twenty_four_hourly: Double
    public var so2_sub_index: Double
    public var so2_twenty_four_hourly: Double

}
