//
//  AirQualityListView.swift
//  Singapore Breathe
//
//  Created by Stuart Breckenridge on 26/12/2020.
//

import SwiftUI

struct AirQualityListView: View {
    
    @StateObject private var model = AirQualityViewModel()
    
    var body: some View {
        List {
            
        }
        .listStyle(InsetGroupedListStyle())
        .onAppear { model.api.getLatestMetadataReading() }
        .alert(isPresented: $model.showError, content: {
            Alert(title: Text(L10N.apiErrorTitle), message: Text(model.apiError!.localizedDescription), dismissButton: .default(Text(L10N.apiErrorDismiss)))
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AirQualityListView()
    }
}
