//
//  PSIModel.swift
//  Singapore Breathe
//
//  Created by Stuart Breckenridge on 26/12/2020.
//

import Foundation


// MARK: - PSI
public struct PSI: Codable {
    public let regionMetadata: [RegionMetadatum]
    public let items: [PSIItem]
    public let apiInfo: APIInfo

    enum CodingKeys: String, CodingKey {
        case regionMetadata = "region_metadata"
        case items = "items"
        case apiInfo = "api_info"
    }

    public init(regionMetadata: [RegionMetadatum], items: [PSIItem], apiInfo: APIInfo) {
        self.regionMetadata = regionMetadata
        self.items = items
        self.apiInfo = apiInfo
    }
}

// MARK: - APIInfo
public struct APIInfo: Codable {
    public let status: String

    enum CodingKeys: String, CodingKey {
        case status = "status"
    }

    public init(status: String) {
        self.status = status
    }
}

// MARK: - PSIItem
public struct PSIItem: Codable {
    public let timestamp: String
    public let updateTimestamp: String
    public let readings: [String: Reading]

    enum CodingKeys: String, CodingKey {
        case timestamp = "timestamp"
        case updateTimestamp = "update_timestamp"
        case readings = "readings"
    }

    public init(timestamp: String, updateTimestamp: String, readings: [String: Reading]) {
        self.timestamp = timestamp
        self.updateTimestamp = updateTimestamp
        self.readings = readings
    }
}

// MARK: - Reading
public struct Reading: Codable {
    public let west: Double
    public let national: Double
    public let east: Double
    public let central: Double
    public let south: Double
    public let north: Double

    enum CodingKeys: String, CodingKey {
        case west = "west"
        case national = "national"
        case east = "east"
        case central = "central"
        case south = "south"
        case north = "north"
    }

    public init(west: Double, national: Double, east: Double, central: Double, south: Double, north: Double) {
        self.west = west
        self.national = national
        self.east = east
        self.central = central
        self.south = south
        self.north = north
    }
}

// MARK: - RegionMetadatum (Shared between models)
public struct RegionMetadatum: Codable {
    public let name: String
    public let labelLocation: LabelLocation

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case labelLocation = "label_location"
    }

    public init(name: String, labelLocation: LabelLocation) {
        self.name = name
        self.labelLocation = labelLocation
    }
}

// MARK: - LabelLocation (Shared between models)
public struct LabelLocation: Codable {
    public let latitude: Double
    public let longitude: Double

    enum CodingKeys: String, CodingKey {
        case latitude = "latitude"
        case longitude = "longitude"
    }

    public init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}
