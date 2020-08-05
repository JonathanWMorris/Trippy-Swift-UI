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

class Places: Object, Identifiable {
    @objc dynamic var id:String = ""
    @objc dynamic var name:String = ""
    @objc dynamic var image:String = ""
    @objc dynamic var photo1:String = ""
    @objc dynamic var photo2:String = ""
    @objc dynamic var photo3:String = ""
    @objc dynamic var rating:Double = 0
    @objc dynamic var price:String = "$"
    @objc dynamic var reviewCount:Int = 0
    @objc dynamic var phone:String = ""
    @objc dynamic var category:String = ""
    @objc dynamic var url:String = "https://www.google.com"
    @objc dynamic var address:String = ""
    let trip = LinkingObjects(fromType: Trip.self, property: "places")
}
