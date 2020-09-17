//
//  TripDetailsPage.swift
//  Trippy Swift UI
//
//  Created by Jonathan Morris on 7/23/20.
//

import SwiftUI
import MapKit
import RealmSwift

struct TripDetailsPage: View {
    @EnvironmentObject var trippyViewModel:TrippyViewModel
    @State var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0),
        span: MKCoordinateSpan(latitudeDelta: 2.0, longitudeDelta: 2.0)
    )
    
    var trip:Trip
    var cityName:String
    var fromDate:Date
    var toDate:Date
    let realm = try! Realm()
    @State var places:Results<Place>? = nil
    
    @State private var showSheet:Bool = false
    @State private var showSelectedPlace:Bool = false
    
    var body: some View {
        VStack(alignment: .leading){
            (Text("\(trippyViewModel.getFormattedDate(with: fromDate)) - ")
                + Text(trippyViewModel.getFormattedDate(with: toDate)))
                .padding(.leading)
            Map(coordinateRegion: $region)
                .frame(height: 200)
            
            if places != nil && !places!.isEmpty{
                List{
                    ForEach(places!) { place in
                        Button(action: {
                            trippyViewModel.selectedID = place.id
                            showSelectedPlace = true
                            showSheet = true
                        }){
                            PlaceView(place: CleanYelpBulkPlaceModel(
                                        ratingImage: trippyViewModel.getRatingImage(with: place.rating),
                                        price: place.price, id: place.id,
                                        reviewCount: place.reviewCount,
                                        name: place.name,
                                        image: trippyViewModel.getImage(url: place.imageURL),
                                        address: place.address))
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    #warning("uncomment when it starts working")
//                    .onDelete { (Index) in
//                        DispatchQueue.main.async {
//                            try! realm.write{
//                                trip.places.remove(atOffsets: Index)
//                            }
//                        }
//                    }
                }
            }
            Spacer()
                .navigationTitle(cityName)
        }
        .onDisappear(perform: {
            trippyViewModel.selectedTrip = trip
        })
        .onAppear{
            places = trip.places.sorted(byKeyPath: "timeAdded", ascending: false)
        }
        .navigationBarItems(trailing: Button(action: {
            showSheet = true
        }, label: {
            Image(systemName: "magnifyingglass")
                .font(.title)
        }))
        .sheet(isPresented: $showSheet) {
            if showSheet && !showSelectedPlace{
                CategoryView(coordinates: region.center)
                    .environmentObject(trippyViewModel)
            }else{
                PlaceDeatailView(trip:trip)
                    .environmentObject(trippyViewModel)
            }
        }
    }
}

struct TripDetailsPage_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView{
                TripDetailsPage(trip: Trip(), cityName: "London",fromDate: Date(), toDate: Date())
                    .environmentObject(TrippyViewModel())
                    .environment(\.colorScheme, .light)
            }
            NavigationView{
                TripDetailsPage(trip: Trip(), cityName: "London",fromDate: Date(), toDate: Date())
                    .environmentObject(TrippyViewModel())
            }
            .preferredColorScheme(.dark)
        }
    }
}
