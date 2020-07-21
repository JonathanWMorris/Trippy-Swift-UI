//
//  Annotation Model.swift
//  Trippy Swift UI
//
//  Created by Jonathan Morris on 7/20/20.
//

import Foundation
import MapKit
struct Annotation: Identifiable {
    var id = UUID()
    var title:String
    var coordinate:CLLocationCoordinate2D
}

#warning("Delete after testing")
extension Annotation {
    static func getLocation() -> [Annotation] {
        return [
            Annotation(title: "KLCC Park", coordinate: CLLocationCoordinate2D(latitude: 3.155699, longitude: 101.713934)),
            Annotation(title: "Twin Tower", coordinate: CLLocationCoordinate2D(latitude: 3.157804, longitude: 101.711869))
        ]
    }
}
