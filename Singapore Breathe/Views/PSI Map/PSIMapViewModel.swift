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
import CoreData


public final class PSIMapViewModel: ObservableObject {
    
    public let api = APIInteractor.shared
    
    init() {
        api.$apiError.receive(on: OperationQueue.main).sink { [weak self] (error) in
            self?.apiError = error
        }.store(in: &bag)
    }
    
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
