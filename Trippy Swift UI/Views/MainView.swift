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
                    if trippyViewModel.allTrips != nil {
                        ForEach(trippyViewModel.allTrips!){trip in
                            let region = MKCoordinateRegion(
                                center: CLLocationCoordinate2D(latitude: trip.locationLat, longitude: trip.locationLon),
                                span: MKCoordinateSpan(latitudeDelta: 2.0, longitudeDelta: 2.0)
                            )
                            NavigationLink(destination: TripDetailsPage(region: region, trip:trip, cityName: trip.cityName, fromDate: trip.fromDate, toDate: trip.toDate), label: {
                                MapView(mapRegion: region, cityName: trip.cityName, fromDate: trip.fromDate, toDate: trip.toDate)
                            })
                            .buttonStyle(PlainButtonStyle())
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
        Group {
            MainView()
                .environmentObject(TrippyViewModel())
            MainView()
                .preferredColorScheme(.dark)
                .environmentObject(TrippyViewModel())
        }
    }
}
