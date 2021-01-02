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
        }.padding(4).background(psiColorCode())
    }
    
    func psiColorCode() -> Color {
        
        switch psiAnnotationData.psi_twenty_four_hourly {
        case 0...50:
            return Color("psiGood")
        case 51...100:
            return Color("psiModerate")
        case 101...200:
            return Color("psiUnhealthy")
        case 201...300:
            return Color("psiVeryUnhealthy")
        case 301...Double.greatestFiniteMagnitude:
            return Color("psiHazardous")
        default:
            return Color("psiGood")
        }
    }
    
    
}
