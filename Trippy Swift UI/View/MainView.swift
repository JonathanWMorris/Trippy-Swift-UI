//
//  MainView.swift
//  Trippy Swift UI
//
//  Created by Jonathan Morris on 7/20/20.
//

import SwiftUI
import MapKit

struct MainView: View {
    
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275),
                                                   span: MKCoordinateSpan(latitudeDelta: 1.0, longitudeDelta: 1.0))
    @State private var name = ""
    @State private var fromDate = Date()
    @State private var toDate = Date()
    
    var body: some View {
        NavigationView{
            ScrollView{
                #warning("This is just temperory")
                Button(action: {}, label: {
                    MapView(mapRegion: $region, cityName: "London", fromDate: fromDate, toDate: toDate)
                })
            }
            .navigationTitle("Trips")
            .navigationBarItems(trailing:
                NavigationLink(destination: AddTripView(fromDate: $fromDate, toDate: $toDate, cityName: $name),
                    label: {
                        Image(systemName: "plus")
                            .font(.title)
                    })
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
