//
//  AirQualityModel.swift
//  Singapore Breathe
//
//  Created by Stuart Breckenridge on 26/12/2020.
//

import Foundation


/// `AirQuality` combines the `PM25Model` and `PSIModel` structs into a single model.
public struct AirQuality: Codable {
    public let combinedRegionMetadatum: [CombinedRegionMetadatum]
}

public struct CombinedRegionMetadatum: Codable {
    public let name: String
    public let location: LabelLocation
    public let pm25Hourly: Int?
    public let psiHourly: Double?
    public let timeStamp: String
    public let updatedTimeStamp: String
}
