//
//  Color+Ratings.swift
//  Singapore Breathe
//
//  Created by Stuart Breckenridge on 03/01/2021.
//

import SwiftUI


public extension Color {
    
    static func psiColor(value: Double) -> Color {
        switch value {
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
    
    static func pm25Color(value: Double) -> Color {
        switch value {
        case 0...55:
            return Color("pmNormal")
        case 56...150:
            return Color("pmElevated")
        case 151...250:
            return Color("pmHigh")
        case 251...Double.greatestFiniteMagnitude:
            return Color("pmVeryHigh")
        default:
            return Color("pmNormal")
        }
    }
}


