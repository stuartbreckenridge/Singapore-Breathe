//
//  PSIMapView.swift
//  Singapore Breathe
//
//  Created by Stuart Breckenridge on 26/12/2020.
//

import SwiftUI
import MapKit

struct PSIMapView: View {
    
    @StateObject private var model = PSIMapViewModel()
    @State private var singaporeRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 1.3521, longitude: 103.8198), latitudinalMeters: 50000, longitudinalMeters: 50000)
    
    @ViewBuilder
    var body: some View {
        ZStack {
            Map(coordinateRegion: $singaporeRegion, annotationItems: model.latestPSIData, annotationContent: { psiReading in
                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: psiReading.location.latitude, longitude: psiReading.location.longitude), content: {
                    PSIMapAnnotation(psiAnnotationData: psiReading)
                        .onTapGesture {
                            model.selectedPSIAnnotationData = psiReading
                        }
                })
            })
            VStack {
                Spacer()
                PSIDetailsCardView(psiData: model.selectedPSIAnnotationData, showCard: $model.showPSICard)
                    .background(VisualEffectBlur(blurStyle: .prominent))
                    .cornerRadius(30)
                    .padding(.horizontal, 4)
                    .scaleEffect(x: model.showPSICard ? 1.0 : 0, y: model.showPSICard ? 1.0 : 0, anchor: .bottom)
                    .animation(.spring(response: 0.6, dampingFraction: 0.9, blendDuration: 0))
            }
            .padding(EdgeInsets(top: 0, leading: 20, bottom: 30, trailing: 20))
            
            
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear{
            model.api.getLatestMetadataReading()
        }.sheet(isPresented: $model.showDetailsSheet, content: {
            Text("")
        })
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PSIMapView()
    }
}
