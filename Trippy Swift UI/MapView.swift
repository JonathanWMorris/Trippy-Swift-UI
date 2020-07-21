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
    @Binding var cityName:String
    var body: some View {
        ZStack{
            Map(coordinateRegion: $mapRegion)
                .cornerRadius(10)
                .shadow(radius: 10)
            
            LinearGradient(gradient: Gradient(colors: [.clear, .gray]), startPoint: .top, endPoint: .bottom)
            
            
            VStack{
                Spacer()
                HStack {
                    Text(cityName)
                        .padding([.bottom,.leading], 50)
                        .font(.title)
                        .foregroundColor(.white)
                    Spacer()
                }
            }
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(mapRegion:.constant(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275),
                                                       span: MKCoordinateSpan(latitudeDelta: 1.0, longitudeDelta: 1.0))), cityName:.constant("London"))
            .previewLayout(.sizeThatFits)
            .padding(.all, 20)
            .frame(width: 400, height: 400, alignment: .center)
    }
}
