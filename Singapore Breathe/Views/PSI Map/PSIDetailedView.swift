//
//  PSIDetailedView.swift
//  Singapore Breathe
//
//  Created by Stuart Breckenridge on 30/12/2020.
//

import SwiftUI

struct PSIDetailedView: View {
    
    var psiData: PSIAnnotationData?
    @AppStorage("showDefinitions") private var showDefinitions: Bool = true
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        if psiData != nil {
            NavigationView {
                List {
                    timestamp
                    Section(header: colourCodingExplainer, content: {})
                    psiSection
                    fineParticulateMatter
                    particulateMatter
                    carbonMonoxide
                    nitrogenDioxide
                    ozone
                    sulphurDioxide
                }
                .listStyle(InsetGroupedListStyle())
                .navigationTitle(
                    Text("\(psiData!.name) Readings")
                )
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(
                    leading:
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }, label: {
                            Text("Done")
                        })
                    , trailing: Button(action: {
                    showDefinitions.toggle()
                }, label: {
                    Image(systemName: "questionmark.circle")
                }))
            }
        } else {
            EmptyView()
        }
    }
    
    
    var colourCodingExplainer: some View {
        
        GeometryReader(content: { metrics in
            LazyVGrid(columns: [
                GridItem(.fixed(metrics.size.width/5), spacing: 0, alignment: .center),
                GridItem(.fixed(metrics.size.width/5), spacing: 0, alignment: .center),
                GridItem(.fixed(metrics.size.width/5), spacing: 0, alignment: .center),
                GridItem(.fixed(metrics.size.width/5), spacing: 0, alignment: .center),
                GridItem(.fixed(metrics.size.width/5), spacing: 0, alignment: .center),
            ], content: {
                ZStack {
                    Rectangle().foregroundColor(Color("psiGood"))
                    Text(L10N.good).foregroundColor(.white).font(Font.system(.caption2, design: .rounded)).bold()
                }.frame(height: 50)
                ZStack {
                    Rectangle().foregroundColor(Color("psiModerate"))
                    Text(L10N.moderate).foregroundColor(.white).font(Font.system(.caption2, design: .rounded)).bold()
                }.frame(height: 50)
                ZStack {
                    Rectangle().foregroundColor(Color("psiUnhealthy"))
                    Text(L10N.unhealthy).foregroundColor(.white).font(Font.system(.caption2, design: .rounded)).bold()
                }.frame(height: 50)
                ZStack {
                    Rectangle().foregroundColor(Color("psiVeryUnhealthy"))
                    Text(L10N.veryUnhealthy).foregroundColor(.white).font(Font.system(.caption2, design: .rounded)).bold()
                }.frame(height: 50)
                ZStack {
                    Rectangle().foregroundColor(Color("psiHazardous"))
                    Text(L10N.hazardous).foregroundColor(.white).font(Font.system(.caption2, design: .rounded)).bold()
                }.frame(height: 50)
            }).multilineTextAlignment(.center).cornerRadius(10)
        })
        
        
        
    }
    
    
    var timestamp: some View {
        Section(header: HStack {
            Spacer()
            Text(psiData!.timestamp.toString()).font(.caption).textCase(.none)
            Spacer()
        }, content: {}).padding(.bottom, -24)
    }
    
    @ViewBuilder
    var psiSection: some View {
        Section(header: Text(L10N.psiLong).font(.title3).bold().textCase(.none).foregroundColor(.primary).padding(.top, 12), content: {
            HStack {
                Text(L10N.psiShort).bold()
                Spacer()
                Capsule(style: .continuous)
                    .foregroundColor(psiColorCode(psiData!.psi_twenty_four_hourly))
                    .overlay(
                            Text(psiData!.psi_twenty_four_hourly.displayString).bold().foregroundColor(.white).padding(4)
                    )
                    .frame(maxWidth: 60, minHeight: 25)
                    .padding(.trailing, -10)
            }
            if showDefinitions {
                VStack(alignment: .leading) {
                    Text("The PSI considers six air pollutants - sulphur dioxide (SO2), particulate matter (PM10), fine particulate matter (PM2.5), nitrogen dioxide (NO2), carbon monoxide (CO) and ozone (O3).\n\n") + Text("Use this reading when planning next day activities.").bold()
                }
            }
            
        })
    }
    
    @ViewBuilder
    var fineParticulateMatter: some View {
        Section(header: Text(L10N.pmFineLong).font(.title3).bold().foregroundColor(.primary).textCase(.none), content: {
            HStack {
                Text(L10N.pmShort)
                    .bold() +
                Text("2.5 ")
                .baselineOffset(-4)
                .font(.caption)
                .bold()
                    +
                Text(L10N.timeHourly).bold()
                Spacer()
                Capsule(style: .continuous)
                    .foregroundColor(Color.pm25Color(value: psiData!.pm25_one_hourly))
                    .overlay(
                        Text(psiData!.pm25_one_hourly.displayString).bold().foregroundColor(.white).padding(4)
                    )
                    .frame(maxWidth: 60, minHeight: 25)
                    .padding(.trailing, -10)
            }
            if showDefinitions {
                VStack(alignment: .leading) {
                    Text("Particulate matter contains microscopic solids or liquid droplets that are so small that they can be inhaled and cause serious health problems. Some particles less than 10 micrometers in diameter can get deep into your lungs and some may even get into your bloodstream. Of these, particles less than 2.5 micrometers in diameter, also known as fine particles or PM2.5, pose the greatest risk to health.\n\n") + Text("Use this reading when planning immediate activities.").bold()
                }
            }
            
        })
    }
    
    
    @ViewBuilder
    var particulateMatter: some View {
        Section(header: Text("Particulate Matter").font(.title3).bold().foregroundColor(.primary).textCase(.none), content: {
            HStack {
                Text("PM").bold() + Text("10 ").font(.caption).baselineOffset(-4).bold() + Text(L10N.time24).bold()
                Spacer()
                Capsule(style: .continuous)
                    .foregroundColor(Color.pm25Color(value: psiData!.pm10_twenty_four_hourly))
                    .overlay(Text(psiData!.pm10_twenty_four_hourly.displayString).bold().foregroundColor(.white).padding(4))
                    .frame(maxWidth: 60, minHeight: 25)
                    .padding(.trailing, -10)
            }
            if showDefinitions  {
                VStack(alignment: .leading) {
                    Text("Particulate matter contains microscopic solids or liquid droplets that are so small that they can be inhaled and cause serious health problems.")
                }
            }
        })
    }
    
    @ViewBuilder
    var ozone: some View {
        Section(header: Text("Ozone").font(.title3).bold().foregroundColor(.primary).textCase(.none), content: {
            HStack {
                Text("O3 ").bold() + Text(L10N.time8).bold()
                Spacer()
                Capsule(style: .continuous)
                    .foregroundColor(psiColorCode(psiData!.o3_eight_hour_max))
                    .overlay(Text(psiData!.o3_eight_hour_max.displayString).bold().foregroundColor(.white).padding(4))
                    .frame(maxWidth: 60, minHeight: 25)
                    .padding(.trailing, -10)
            }
            if showDefinitions {
                VStack(alignment: .leading) {
                    Text("Ozone (O3) is a highly reactive gas composed of three oxygen atoms. It is both a natural and a man-made product that occurs in the Earth's upper atmosphere ozone molecule(the stratosphere) and lower atmosphere (the troposphere).  Depending on where it is in the atmosphere, ozone affects life on Earth in either good or bad ways.")
                }
            }
        })
    }
    
    @ViewBuilder
    var nitrogenDioxide: some View {
        Section(header: Text("Nitrogen Dioxide").font(.title3).bold().foregroundColor(.primary).textCase(.none), content: {
            HStack {
                Text("NO").bold() + Text("2 ").font(.caption).baselineOffset(-4).bold() + Text(L10N.timeOneMax).bold()
                Spacer()
                Capsule(style: .continuous)
                    .foregroundColor(psiColorCode(psiData!.no2_one_hour_max))
                    .overlay(Text(psiData!.no2_one_hour_max.displayString).bold().foregroundColor(.white).padding(4))
                    .frame(maxWidth: 60, minHeight: 25)
                    .padding(.trailing, -10)
            }
            if showDefinitions {
                VStack(alignment: .leading) {
                    Text("Breathing air with a high concentration of NO2 can irritate airways in the human respiratory system. Such exposures over short periods can aggravate respiratory diseases, particularly asthma, leading to respiratory symptoms (such as coughing, wheezing or difficulty breathing), hospital admissions and visits to emergency rooms.\n\nLonger exposures to elevated concentrations of NO2 may contribute to the development of asthma and potentially increase susceptibility to respiratory infections. People with asthma, as well as children and the elderly are generally at greater risk for  the health effects of NO2.")
                }
            }
            
        })
    }
    
    @ViewBuilder
    var carbonMonoxide: some View {
        Section(header: Text("Carbon Monoxide").font(.title3).bold().foregroundColor(.primary).textCase(.none), content: {
            HStack {
                Text("CO ").bold() + Text(L10N.time8).bold()
                Spacer()
                Capsule(style: .continuous)
                    .foregroundColor(psiColorCode(psiData!.co_eight_hour_max))
                    .overlay(Text(psiData!.co_eight_hour_max.displayString).bold().foregroundColor(.white).padding(4))
                    .frame(maxWidth: 60, minHeight: 25)
                    .padding(.trailing, -10)
            }
            if showDefinitions {
                VStack(alignment: .leading) {
                    Text("Breathing air with a high concentration of CO reduces the amount of oxygen that can be transported in the blood stream to critical organs like the heart and brain.\n\nAt very high levels, which are  possible indoors or in other enclosed environments, CO can cause dizziness, confusion, unconsciousness and death.")
                }
            }
            
        })
    }
    
    @ViewBuilder
    var sulphurDioxide: some View {
        Section(header: Text("Sulphur Dioxide").font(.title3).bold().foregroundColor(.primary).textCase(.none), content: {
            HStack {
                Text("SO").bold() + Text("2  ").font(.caption).baselineOffset(-4).bold() + Text(L10N.time24).bold()
                Spacer()
                Capsule(style: .continuous)
                    .foregroundColor(psiColorCode(psiData!.co_eight_hour_max))
                    .overlay(Text(psiData!.co_eight_hour_max.displayString).bold().foregroundColor(.white).padding(4))
                    .frame(maxWidth: 60, minHeight: 25)
                    .padding(.trailing, -10)
            }
            if showDefinitions {
                VStack(alignment: .leading) {
                    Text("Short-term exposures to SO2 can harm the human respiratory system and make breathing difficult. People with asthma, particularly children, are sensitive to these effects of SO2.")
                }
            }
            
        })
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
        PSIDetailedView(psiData: PSIAnnotationData(name: "west", location: LabelLocation(latitude: 1.35735, longitude: 103.7), timestamp: Date(), updatedTimestamp: Date().addingTimeInterval(8), co_eight_hour_max: 10, co_sub_index: 10, no2_one_hour_max: 10, o3_eight_hour_max: 10, o3_sub_index: 10, pm10_sub_index: 10, pm10_twenty_four_hourly: 10, pm25_one_hourly: 10, pm25_sub_index: 10, pm25_twenty_four_hourly: 10, psi_twenty_four_hourly: 10, so2_sub_index: 10, so2_twenty_four_hourly: 10.23))
    }
}
