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
    
    var body: some View {
        NavigationView{
            ZStack{
                ScrollView{
                    if trippyViewModel.trips != nil {
                        ForEach(trippyViewModel.trips!){trip in
                            let region = MKCoordinateRegion(
                                center: CLLocationCoordinate2D(latitude: trip.locationLat, longitude: trip.locationLon),
                                span: MKCoordinateSpan(latitudeDelta: 2.0, longitudeDelta: 2.0)
                            )
                            NavigationLink(destination: TripDetailsPage(region: region, cityName: trip.cityName, fromDate: trip.fromDate, toDate: trip.toDate), label: {
                                MapView(mapRegion: region, cityName: trip.cityName, fromDate: trip.fromDate, toDate: trip.toDate)
                            })
                        }
                    }
                }
                .navigationTitle("Trips")
                .navigationBarItems(
                    trailing: NavigationLink(destination: AddTripView(),
                                             label: {Image(systemName: "plus")
                                                .font(.title)})
                )
            }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(TrippyViewModel())
            .environment(\.colorScheme, .light)
    }
}
