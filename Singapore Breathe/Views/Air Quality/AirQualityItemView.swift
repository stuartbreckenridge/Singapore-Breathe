//
//  AirQualityItemView.swift
//  Singapore Breathe
//
//  Created by Stuart Breckenridge on 27/12/2020.
//

import SwiftUI

struct AirQualityItemView: View {
    
    var airQualityItem: CombinedRegionMetadatum
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(L10N.psiShort).font(.system(size: 25, weight: .black, design: .default))
                if airQualityItem.psiHourly != nil {
                    Text("\(airQualityItem.psiHourly!)")
                }
            }
            Spacer()
            VStack (alignment: .trailing, spacing: 4) {
                Text(L10N.pmShort).font(.system(size: 25, weight: .black, design: .default)) + Text("2.5").font(.system(size: 12.5, weight: .black, design: .default)).baselineOffset(0.0)
                if airQualityItem.pm25Hourly != nil {
                    Text("\(airQualityItem.pm25Hourly!)") +
                        Text("µg/m") + Text("3").font(.footnote).baselineOffset(5)
                }
            }
        }
    }
}

struct AirQualityItemView_Previews: PreviewProvider {
    static var previews: some View {
        AirQualityItemView(airQualityItem: CombinedRegionMetadatum(name: "North", location: LabelLocation(latitude: 1.3521, longitude: 103.8198), pm25Hourly: 12, psiHourly: 12, timeStamp: "2020-12-25T20:00:00+08:00", updatedTimeStamp: "2020-12-25T20:08:52+08:00"))
    }
}
