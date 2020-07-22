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
    @Environment(\.colorScheme) var colorScheme
    
    @State private var name = ""
    @State private var fromDate = Date()
    @State private var toDate = Date()
    
    var body: some View {
        NavigationView{
            ZStack{
                Color(.init(white: colorScheme == .dark ? 0.15:1, alpha: 1))
                    .edgesIgnoringSafeArea(.all)
                ScrollView{
                    if trippyViewModel.trips != nil {
                        ForEach(trippyViewModel.trips!){trip in
                            Button(action: {}, label: {
                                let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: trip.locationLat, longitude: trip.locationLon),
                                                                span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
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
            }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(TrippyViewModel())
    }
}
