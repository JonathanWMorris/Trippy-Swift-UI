//
//  MapView.swift
//  Trippy Swift UI
//
//  Created by Jonathan Morris on 7/21/20.
//

import SwiftUI
import MapKit

struct MapView: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var trippyViewModel:TrippyViewModel
    
    @State var mapRegion = MKCoordinateRegion()
    
    var cityName:String
    var fromDate: Date
    var toDate: Date
    
    var body: some View {
        ZStack{
            
            Map(coordinateRegion: $mapRegion)
            
            Color(.init(white: colorScheme == .dark ? 0:1, alpha: 0.3))
                .blur(radius: 10)
            
            VStack{
                Spacer()
                HStack {
                    Text(cityName)
                        .fontWeight(.heavy)
                        .padding([.trailing,.top,.leading],5)
                        .font(.largeTitle)
                        .foregroundColor(colorScheme == .dark ? .white:.black)
                        .background(Color(.init(white: colorScheme == .dark ? 0.1:1, alpha: 0.3))
                                        .blur(radius: 1))
                    Spacer()
                }.padding(.leading, 5)
                
                HStack {
                    (Text("\(trippyViewModel.getFormattedDate(with: fromDate)) -")
                        + Text("\(trippyViewModel.getFormattedDate(with: toDate))"))
                        .fontWeight(.regular)
                        .font(.body)
                        .padding([.trailing,.bottom],5)
                        .foregroundColor(colorScheme == .dark ? .white:.black)
                        .background(Color(.init(white: colorScheme == .dark ? 0.1:1, alpha: 0.3))
                                        .blur(radius: 1))
                    Spacer()
                }.padding(.bottom, 20).padding(.leading,10)
            }
        }
        .frame(height: 200, alignment: .center)
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding(.all, 10)
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MapView(cityName:"London", fromDate: Date(), toDate: Date())
                .environment(\.colorScheme, .light)
                .previewLayout(.sizeThatFits)
                .environmentObject(TrippyViewModel())
            MapView(cityName:"London", fromDate: Date(), toDate: Date())
                .environment(\.colorScheme, .dark)
                .previewLayout(.sizeThatFits)
                .environmentObject(TrippyViewModel())
        }
    }
}
