//
//  PSIMapView.swift
//  Singapore Breathe
//
//  Created by Stuart Breckenridge on 26/12/2020.
//

import SwiftUI
import MapKit
import CoreData

struct PSIMapView: View {
    
    @StateObject private var model = PSIMapViewModel()
    @State private var singaporeRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 1.3521, longitude: 103.8198), latitudinalMeters: 50000, longitudinalMeters: 50000)
    
    @FetchRequest(entity: RegionalAQM.entity(), sortDescriptors: [NSSortDescriptor(key: "timestamp", ascending: true)], predicate: NSPredicate(format: "region != %@", "national"), animation: nil)
    var readings: FetchedResults<RegionalAQM>
    
    @ViewBuilder
    var body: some View {
        ZStack {
            Map(coordinateRegion: $singaporeRegion, annotationItems: readings.prefix(5), annotationContent: { psiReading in
                
                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: psiReading.latitude, longitude: psiReading.longitude), content: {
                    PSIMapAnnotation(psiAnnotationData: aqmAsPSIData(aqm: psiReading)).onTapGesture {
                        model.selectedPSIAnnotationData = aqmAsPSIData(aqm: psiReading)
                    }
                })
                
                
                
//                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: psiReading.location.latitude, longitude: psiReading.location.longitude), content: {
//                    PSIMapAnnotation(psiAnnotationData: psiReading)
//                        .onTapGesture {
//                            model.selectedPSIAnnotationData = psiReading
//                        }
//                })
                
            })
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear{
            model.api.getLatestMetadataReading()
        }
        .sheet(isPresented: $model.showPSICard, content: {
            PSIDetailsCardView(psiData: model.selectedPSIAnnotationData)
        })
    }
    
    func aqmAsPSIData(aqm: RegionalAQM) -> PSIAnnotationData {
        PSIAnnotationData(name: aqm.region!.capitalized,
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
                          so2_twenty_four_hourly: aqm.so2_twenty_four_hourly)
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PSIMapView()
    }
}
