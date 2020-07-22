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
    var cityName:String
    var fromDate: Date
    var toDate: Date
    
    var fromDateString: String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "en_US")
        return dateFormatter.string(from: fromDate)
    }
    var toDateString: String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "en_US")
        
        return dateFormatter.string(from: toDate)
    }
    
    var body: some View {
        ZStack{
            Map(coordinateRegion: $mapRegion)
            
            LinearGradient(gradient: Gradient(colors: [.clear, Color(UIColor(white: 0.5, alpha: 0.7))]), startPoint: .top, endPoint: .bottom)
    
            VStack{
                
                Spacer()
                
                HStack {
                    Text(cityName)
                        .fontWeight(.heavy)
                        .padding([.leading], 20)
                        .font(.largeTitle)
                        .foregroundColor(.white)
                    Spacer()
                }
                
                HStack {
                    Text("\(fromDateString) - ")
                        .fontWeight(.regular)
                        .font(.body)
                        .foregroundColor(.white)
                    Text("\(toDateString)")
                        .fontWeight(.regular)
                        .font(.body)
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding([.bottom,.leading], 20)
                
            }
        }
        .frame(height: 200, alignment: .center)
        .cornerRadius(10)
        .shadow(radius: 10)
        .padding(.all, 10)
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(cityName:"London", fromDate: Date(), toDate: Date())
            .previewLayout(.sizeThatFits)
            
            
    }
}
