//
//  MapView.swift
//  Trippy Swift UI
//
//  Created by Jonathan Morris on 7/21/20.
//

import SwiftUI
import MapKit

struct MapView: View {
    @State var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    @Environment(\.colorScheme) var colorScheme
    var cityName:String
    var fromDate: Date
    var toDate: Date
    
    func dateFormatter() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "en_US")
        return dateFormatter
    }
    
    var fromDateString: String{
        return dateFormatter().string(from: fromDate)
    }
    var toDateString: String{
        return dateFormatter().string(from: toDate)
    }
    
    var body: some View {
        ZStack{
            
            Map(coordinateRegion: $mapRegion)
            
            Color(.init(white: colorScheme == .dark ? 0:1, alpha: 0.3))
                .blur(radius: 10)
            
            VStack{
                Spacer()
                VStack{
                    HStack {
                        Text(cityName)
                            .fontWeight(.heavy)
                            
                            .font(.largeTitle)
                            .foregroundColor(colorScheme == .dark ? .white:.black)
                            .background(Color(.init(white: colorScheme == .dark ? 0:1, alpha: 0.3))
                                            .blur(radius: 1))
                        Spacer()
                    }.padding(.leading, 10)

                    HStack {
                        Text("\(fromDateString) -")
                            .fontWeight(.regular)
                            .font(.body)
                            .foregroundColor(colorScheme == .dark ? .white:.black)
                            .background(Color(.init(white: colorScheme == .dark ? 0:1, alpha: 0.3))
                                            .blur(radius: 1))
                            .padding(.leading, 10)
                        Text("\(toDateString)")
                            .fontWeight(.regular)
                            .font(.body)
                            .foregroundColor(colorScheme == .dark ? .white:.black)
                            .background(Color(.init(white: colorScheme == .dark ? 0:1, alpha: 0.3))
                                            .blur(radius: 1))
                        
                        Spacer()
                    }.padding(.bottom, 30)
                }
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
        MapView(cityName:"London", fromDate: Date(), toDate: Date())
            .previewLayout(.sizeThatFits)
    }
}
