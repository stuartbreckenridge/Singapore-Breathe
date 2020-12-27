//
//  AirQualityMapView.swift
//  Singapore Breathe
//
//  Created by Stuart Breckenridge on 26/12/2020.
//

import SwiftUI
import MapKit

struct AirQualityMapView: View {
    
    @StateObject private var model = AirQualityViewModel()
    @State private var singaporeRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 1.3521, longitude: 103.8198), latitudinalMeters: 50000, longitudinalMeters: 50000)
    
    var body: some View {
        Map(coordinateRegion: $singaporeRegion)
            .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AirQualityMapView()
    }
}
