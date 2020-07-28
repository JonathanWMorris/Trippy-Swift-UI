//
//  YelpPlaceModel.swift
//  Trippy Swift UI
//
//  Created by Jonathan Morris on 7/23/20.
//

import Foundation
import SwiftUI

struct YelpCatergoryModel:Codable {
    let businesses: [YelpBulkPlaceModel]
}
struct YelpBulkPlaceModel:Codable {
    let rating:Double?
    let price:String?
    let phone:String?
    let id:String?
    let categories:[Categories]?
    let review_count:Int?
    let name:String?
    let url:String?
    let image_url:String?
    let location:location?
}

struct CleanYelpBulkPlaceModel:Identifiable {
    let rating:UIImage
    let price:String
    let phone:String
    let id:String
    let category:String
    let reviewCount:Int
    let name:String
    let url:String
    let image:UIImage
    let adress:String
}

struct location:Codable {
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
