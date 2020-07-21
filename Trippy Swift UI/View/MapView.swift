//
//  MapView.swift
//  Trippy Swift UI
//
//  Created by Jonathan Morris on 7/21/20.
//

import SwiftUI
import MapKit

struct MapView: View {
    @Binding var mapRegion: MKCoordinateRegion
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
        
        return dateFormatter.string(from: fromDate)
    }
    
    var body: some View {
        ZStack{
            Map(coordinateRegion: $mapRegion)
            
            LinearGradient(gradient: Gradient(colors: [.clear, .gray]), startPoint: .top, endPoint: .bottom)
    
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
        MapView(mapRegion:.constant(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275),
                                                       span: MKCoordinateSpan(latitudeDelta: 1.0, longitudeDelta: 1.0))), cityName:"London", fromDate: Date(), toDate: Date())
            .previewLayout(.sizeThatFits)
            
            
    }
}
