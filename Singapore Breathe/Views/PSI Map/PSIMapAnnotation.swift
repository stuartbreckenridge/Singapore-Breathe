//
//  PSIMapAnnotation.swift
//  Singapore Breathe
//
//  Created by Stuart Breckenridge on 30/12/2020.
//

import SwiftUI

struct PSIMapAnnotation: View {
    
    var psiAnnotationData: PSIAnnotationData
    
    var body: some View {
        ZStack {
            capsuleText
        }
        .cornerRadius(8)
    }
    
    var capsuleText: some View {
        HStack {
            Text(psiAnnotationData.name)
                .foregroundColor(.white)
                .font(.caption).bold()
            Divider()
            Text(psiAnnotationData.psi_twenty_four_hourly.displayString)
                .foregroundColor(.white)
                .font(.caption).bold()
        }.padding(4).background(Color.psiColor(value: psiAnnotationData.psi_twenty_four_hourly))
    }    
}
