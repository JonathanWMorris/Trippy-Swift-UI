//
//  TripModel.swift
//  Trippy Swift UI
//
//  Created by Jonathan Morris on 7/21/20.
//

import Foundation
import RealmSwift
import MapKit

class Trip: Object, Identifiable {
    var id = UUID()
    @objc dynamic var cityName:String = ""
    @objc dynamic var fromDate:Date = Date()
    @objc dynamic var toDate:Date = Date()
    @objc dynamic var locationLat:Double = 0.0
    @objc dynamic var locationLon:Double = 0.0
    var places = List<Places>()
}

class Places: Object {
    var name:String = ""
    var imageURL:URL = URL(string: "google.com")!
    var stars:Double = 0
}
