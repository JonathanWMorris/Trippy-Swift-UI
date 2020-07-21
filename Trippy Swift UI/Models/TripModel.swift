//
//  TripModel.swift
//  Trippy Swift UI
//
//  Created by Jonathan Morris on 7/21/20.
//

import Foundation
import RealmSwift

class Trip: Object, Identifiable {
    var id = UUID()
    @objc dynamic var name:String = ""
    @objc dynamic var fromDate:Date = Date()
    @objc dynamic var toDate:Date = Date()
    var places = List<Places>()
}

class Places: Object {
    var name:String = ""
    var imageURL:URL = URL(string: "google.com")!
    var stars:Double = 0
}
