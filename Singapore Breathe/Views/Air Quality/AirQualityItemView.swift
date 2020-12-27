//
//  AirQualityItemView.swift
//  Singapore Breathe
//
//  Created by Stuart Breckenridge on 27/12/2020.
//

import SwiftUI

struct AirQualityItemView: View {
    
    var latestPSI: PSI
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                
            }
            Spacer()
            VStack (alignment: .trailing, spacing: 4) {
                
            }
        }
    }
}

struct AirQualityItemView_Previews: PreviewProvider {
    static var previews: some View {
        AirQualityItemView(latestPSI: PSI(regionMetadata: [RegionMetadatum(name: "west", labelLocation: LabelLocation(latitude: 1.35735, longitude: 103.7))], items: [PSIItem(timestamp: "2020", updateTimestamp: "2020", readings: ["Sample" : Reading(west: 0, east: 0, central: 0, south: 0, north: 0)])], apiInfo: APIInfo(status: "Healthy", message: nil)))
    }
}
