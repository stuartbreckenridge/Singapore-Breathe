//
//  AirQualityListView.swift
//  Singapore Breathe
//
//  Created by Stuart Breckenridge on 26/12/2020.
//

import SwiftUI

struct AirQualityListView: View {
    
    @StateObject private var model = AirQualityViewModel()
    @State private var airQuality: AirQuality?
    
    
    var body: some View {
        List {
            ForEach(model.airQuality.combinedRegionMetadatum.sorted(by: { $0.name > $1.name }), id: \.name, content: { item in
                Section(header: Text(item.name)) {
                    AirQualityItemView(airQualityItem: item)
                }
            })
            
            Section(footer: Text(model.airQuality.combinedRegionMetadatum.first?.updatedTimeStamp ?? "")) {}
        }
        .listStyle(InsetGroupedListStyle())
        .onAppear { model.api.getLatestMetadataReading() }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AirQualityListView()
    }
}
