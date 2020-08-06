//
//  TripDetailsPage.swift
//  Trippy Swift UI
//
//  Created by Jonathan Morris on 7/23/20.
//

import SwiftUI
import MapKit

struct TripDetailsPage: View {
    @EnvironmentObject var trippyViewModel:TrippyViewModel
    @State var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0),
        span: MKCoordinateSpan(latitudeDelta: 2.0, longitudeDelta: 2.0)
    )
    
    var cityName:String
    var fromDate:Date
    var toDate:Date
    @State private var showCategorySheet:Bool = false
    
    var body: some View {
        VStack(alignment: .leading){
            (Text("\(trippyViewModel.getFormattedDate(with: fromDate)) - ")
                + Text(trippyViewModel.getFormattedDate(with: toDate)))
                .padding(.leading)
            Map(coordinateRegion: $region)
                .frame(height: 200)
            ScrollView{
                if let places = trippyViewModel.placesForTrip{
                    ForEach(places) { place in
                        PlaceView(place: CleanYelpBulkPlaceModel(
                                    ratingImage: trippyViewModel.getRatingImage(with: place.rating),
                                    price: place.price, id: place.id,
                                    reviewCount: place.reviewCount,
                                    name: place.name,
                                    image: trippyViewModel.getImage(url: place.image),
                                    address: place.address))
                    }
                }
            }
            Spacer()
                .navigationTitle(cityName)
        }
        .navigationBarItems(trailing: Button(action: {
            showCategorySheet = true
        }, label: {
            Image(systemName: "magnifyingglass")
                .font(.title)
        }))
        .sheet(isPresented: $showCategorySheet) {
            CategoryView(coordinates: region.center)
                .environmentObject(trippyViewModel)
        }
        
    }
}

struct TripDetailsPage_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView{
                TripDetailsPage(cityName: "London",fromDate: Date(), toDate: Date())
                    .environmentObject(TrippyViewModel())
                    .environment(\.colorScheme, .light)
            }
            NavigationView{
                TripDetailsPage(cityName: "London",fromDate: Date(), toDate: Date())
                    .environmentObject(TrippyViewModel())
            }
            .preferredColorScheme(.dark)
        }
    }
}
