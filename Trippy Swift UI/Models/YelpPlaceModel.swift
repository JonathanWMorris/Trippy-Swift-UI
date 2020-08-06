//
//  YelpPlaceModel.swift
//  Trippy Swift UI
//
//  Created by Jonathan Morris on 7/23/20.
//

import Foundation
import SwiftUI
import MapKit

struct YelpCatergoryModel:Codable {
    let businesses: [YelpBulkPlaceModel]
}

struct YelpBulkPlaceModel:Codable {
    let rating:Double?
    let price:String?
    let id:String?
    let review_count:Int?
    let name:String?
    let image_url:String?
    let location:Location?
}

struct CleanYelpBulkPlaceModel:Identifiable {
    let ratingImage:UIImage
    let price:String
    let id:String
    let reviewCount:Int
    let name:String
    let image:UIImage
    let address:String
}

struct YelpBusinessDetailsModel:Codable {
    let id:String?
    let name:String?
    let image_url:String?
    let url:String?
    let phone:String?
    let display_phone:String?
    let rating:Double?
    let review_count:Int?
    let location:Location
    let coordinates:Coordinates?
    let photos:[String]?
    let price:String?
}

struct CleanedBusinessDetailsModel {
    let id:String
    let name:String
    let image:UIImage?
    let imageURL:String
    let url:URL
    let urlString:String
    let phone:String
    let displayPhone:String
    let reviewCount:Int
    let ratingImage:UIImage
    let address:String
    let coordinates:CLLocationCoordinate2D
    let photos:[UIImage]
    let photosURL:[String]
    let price:String
}

//MARK:Supporting Models
struct Coordinates:Codable {
    let latitude:Double
    let longitude:Double
}

struct Location:Codable {
    let city:String?
    let country:String?
    let state:String?
    let address1:String?
    let address2:String?
    let zip_code:String?
}
struct Categories:Codable {
    let alias:String?
    let title:String?
}
