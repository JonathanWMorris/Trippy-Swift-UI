//
//  TrippyViewModel.swift
//  Trippy Swift UI
//
//  Created by Jonathan Morris on 7/21/20.
//

import Foundation
import MapKit
import RealmSwift

class TrippyViewModel:ObservableObject {
    let realm = try! Realm()
    
    @Published var trips:Results<Trip>?
    
    init() {
        trips = realm.objects(Trip.self)
    }
    
    func addTrip(cityName:String, fromDate:Date, toDate:Date){
        //This is to get the coordinates of the place from the City Name
        CLGeocoder().geocodeAddressString(cityName) { (placemarks, error) in
            guard let locationCoordinates = placemarks?.first?.location?.coordinate else{fatalError()}
            
            let newTrip = Trip()
            newTrip.cityName = cityName
            newTrip.locationLat = locationCoordinates.latitude
            newTrip.locationLon = locationCoordinates.longitude
            newTrip.fromDate = fromDate
            newTrip.toDate = toDate
            DispatchQueue.main.async {
                try! self.realm.write{
                    self.realm.add(newTrip)
                }
                self.trips = self.realm.objects(Trip.self)
            }
        }
    }
}

