//
//  PSIDetailsCardView.swift
//  Singapore Breathe
//
//  Created by Stuart Breckenridge on 30/12/2020.
//

import SwiftUI

struct PSIDetailsCardView: View {
    
    var psiData: PSIAnnotationData?
    @Binding var showCard: Bool
    
    var body: some View {
        if let _ = psiData {
            VStack {
                headingView
                Divider()
                psiAndParticulateMatter
                Divider()
                otherReadings
                Divider()
                Spacer()
            }
            .padding()
            .frame(maxHeight: 560)
        }
        else {
            EmptyView()
                .frame(maxHeight: 320)
        }
    }
    
       
    var headingView: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                Text(psiData!.name.capitalized)
                    .font(.title).bold()
                Text("Readings taken on \(psiData!.timestamp.toString(timeStyle: .short, dateStyle: .medium))").font(.caption).foregroundColor(.gray)
            }
            Spacer()
            Button(action: {
                showCard = false
            }, label: {
                Image(systemName:"xmark.circle.fill").foregroundColor(.gray).font(.title2)
            })
        }
    }
    
    @ViewBuilder
    var psiAndParticulateMatter: some View {
        psiReading
        Divider()
        pm25Reading
        Divider()
        pm10Reading
    }
    
    @ViewBuilder
    var otherReadings: some View {
        o3Reading
        Divider()
        no2Reading
        Divider()
        so2Reading
        Divider()
        coReading
    }
    
    
    var psiReading: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                Text("Pollutant Standards Index").bold()
                Text("Use this value when planning next day activities.").font(.caption).foregroundColor(.gray).fixedSize(horizontal: false, vertical: true)
            }
            Spacer()
            Capsule(style: .continuous)
                .foregroundColor(psiColorCode(psiData!.psi_twenty_four_hourly))
                .overlay(Text(psiData!.psi_twenty_four_hourly.displayString).bold().foregroundColor(.white).padding(4))
                .frame(maxWidth: 60, minHeight: 25)
        }
    }
    
    @ViewBuilder
    var pm25Reading: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                (Text("PM").bold() + Text("2.5 ").baselineOffset(-4).font(.caption).bold() + Text("Hourly").bold()).fixedSize(horizontal: false, vertical: true)
                Text("Use this value when planning immediate activities.").font(.caption).foregroundColor(.gray).fixedSize(horizontal: false, vertical: true)
            }
            Spacer()
            Capsule(style: .continuous)
                .foregroundColor(psiColorCode(psiData!.pm25_one_hourly))
                .overlay(Text(psiData!.pm25_one_hourly.displayString).bold().foregroundColor(.white).padding(4))
                .frame(maxWidth: 60, minHeight: 25)
        }.padding(.bottom, 4)
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                Text("PM").bold() + Text("2.5 ").baselineOffset(-4).font(.caption).bold() + Text("24-Hourly").bold()
            }
            Spacer()
            Capsule(style: .continuous)
                .foregroundColor(psiColorCode(psiData!.pm25_twenty_four_hourly))
                .overlay(Text(psiData!.pm25_twenty_four_hourly.displayString).bold().foregroundColor(.white).padding(4))
                .frame(maxWidth: 60, minHeight: 25)
        }
    }

    var pm10Reading: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                Text("PM").bold() + Text("10 ").font(.caption).bold().baselineOffset(-4) + Text("24-Hourly").bold()
            }
            Spacer()
            Capsule(style: .continuous)
                .foregroundColor(psiColorCode(psiData!.pm10_twenty_four_hourly))
                .overlay(Text(psiData!.pm10_twenty_four_hourly.displayString).bold().foregroundColor(.white).padding(4))
                .frame(maxWidth: 60, minHeight: 25)
        }
    }
    
    var o3Reading: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                Text("O").bold() + Text("3 ").font(.caption).baselineOffset(-4).bold() + Text("8-Hour Max").bold()
            }
            Spacer()
            Capsule(style: .continuous)
                .foregroundColor(psiColorCode(psiData!.o3_eight_hour_max))
                .overlay(Text(psiData!.o3_eight_hour_max.displayString).bold().foregroundColor(.white).padding(4))
                .frame(maxWidth: 60, minHeight: 25)
        }
    }
    
    var no2Reading: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                Text("NO").bold() + Text("2 ").font(.caption).baselineOffset(-4).bold() + Text("1-Hour Max").bold()
            }
            Spacer()
            Capsule(style: .continuous)
                .foregroundColor(psiColorCode(psiData!.no2_one_hour_max))
                .overlay(Text(psiData!.no2_one_hour_max.displayString).bold().foregroundColor(.white).padding(4))
                .frame(maxWidth: 60, minHeight: 25)
        }
    }
    
    var coReading: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                Text("CO ").bold() + Text("8-Hour Max").bold()
            }
            Spacer()
            Capsule(style: .continuous)
                .foregroundColor(psiColorCode(psiData!.co_eight_hour_max))
                .overlay(Text(psiData!.co_eight_hour_max.displayString).bold().foregroundColor(.white).padding(4))
                .frame(maxWidth: 60, minHeight: 25)
        }
    }
    
    var so2Reading: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                Text("SO").bold() + Text("2 ").font(.caption).baselineOffset(-4).bold() + Text("24-Hourly").bold()
            }
            Spacer()
            Capsule(style: .continuous)
                .foregroundColor(psiColorCode(psiData!.so2_twenty_four_hourly))
                .overlay(Text(psiData!.so2_twenty_four_hourly.displayString).bold().foregroundColor(.white).padding(4))
                .frame(maxWidth: 60, minHeight: 25)
        }
    }
    
    func psiColorCode(_ currentReading: Double) -> Color {
        
        switch currentReading {
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

struct PSIDetailsCardView_Previews: PreviewProvider {
    static var previews: some View {
        PSIDetailsCardView(psiData: PSIAnnotationData(name: "west", location: LabelLocation(latitude: 1.35735, longitude: 103.7), timestamp: Date(), updatedTimestamp: Date().addingTimeInterval(8), co_eight_hour_max: 10, co_sub_index: 10, no2_one_hour_max: 10, o3_eight_hour_max: 10, o3_sub_index: 10, pm10_sub_index: 10, pm10_twenty_four_hourly: 10, pm25_one_hourly: 10, pm25_sub_index: 10, pm25_twenty_four_hourly: 10, psi_twenty_four_hourly: 10, so2_sub_index: 10, so2_twenty_four_hourly: 10.23), showCard: .constant(true))
    }
}
