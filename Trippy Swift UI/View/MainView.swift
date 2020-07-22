//
//  MainView.swift
//  Trippy Swift UI
//
//  Created by Jonathan Morris on 7/20/20.
//

import SwiftUI
import MapKit

struct MainView: View {
    @EnvironmentObject var trippyViewModel:TrippyViewModel
    
    @State private var name = ""
    @State private var fromDate = Date()
    @State private var toDate = Date()
    
    var body: some View {
        NavigationView{
            ScrollView{
                if trippyViewModel.trips != nil {
                    ForEach(trippyViewModel.trips!){trip in
                        Button(action: {}, label: {
                            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: trip.locationLat, longitude: trip.locationLon),
                                                            span: MKCoordinateSpan(latitudeDelta: 1.0, longitudeDelta: 1.0))
                            MapView(mapRegion: region, cityName: trip.cityName, fromDate: trip.fromDate, toDate: trip.toDate)
                        })
                    }
                }
            }
            .navigationTitle("Trips")
            .navigationBarItems(trailing:
                NavigationLink(destination: AddTripView(fromDate: $fromDate, toDate: $toDate, cityName: $name),
                    label: {
                        Image(systemName: "plus")
                            .font(.title)
                    })
            )
        }.onAppear {
            print(trippyViewModel.trips)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(TrippyViewModel())
    }
}
