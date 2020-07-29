//
//  TrippyViewModel.swift
//  Trippy Swift UI
//
//  Created by Jonathan Morris on 7/21/20.
//

import Foundation
import MapKit
import SwiftUI
import RealmSwift

class TrippyViewModel:ObservableObject {
    let realm = try! Realm()
    let yelpService = YelpService()
    
    @Published var trips:Results<Trip>?
    @Published var placesForTrip:Results<Places>?
    
    @Published var placesForSearch:[CleanYelpBulkPlaceModel]?
    
    let categoriesAvailable: [String] = [
        "Search","Hotels", "Shopping","Food", "Museums",
        "Tours", "Beaches", "Theme Parks","Activities","Spas",
        "Yoga", "Parks", "Zoos", "Aquariums", "Cinema"
    ]
    
    init() {
        trips = realm.objects(Trip.self)
    }
    
    func getFormattedDate(with date:Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        return dateFormatter.string(from: date)
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
    
    func getImage(url:String?) -> UIImage {
        guard url != nil else{return #imageLiteral(resourceName: "placeholder")}
        guard let url = URL(string: url!) else{return #imageLiteral(resourceName: "placeholder")}
        do {
            let data = try Data(contentsOf: url)
            return UIImage(data: data) ?? #imageLiteral(resourceName: "placeholder")
        } catch {
            return #imageLiteral(resourceName: "placeholder")
        }
        
    }
    
    func getStarImage(with number:Double) -> UIImage {
        switch number {
        case 0:
            return #imageLiteral(resourceName: "0")
        case 1:
            return #imageLiteral(resourceName: "1")
        case 1.5:
            return #imageLiteral(resourceName: "1_half")
        case 2:
            return #imageLiteral(resourceName: "2")
        case 2.5:
            return #imageLiteral(resourceName: "2_half")
        case 3:
            return #imageLiteral(resourceName: "3")
        case 4:
            return #imageLiteral(resourceName: "4")
        case 4.5:
            return #imageLiteral(resourceName: "4_half")
        case 5:
            return #imageLiteral(resourceName: "5")
        default:
            return #imageLiteral(resourceName: "0")
        }
    }
    
    func getCategorySugessions(coordinates:CLLocationCoordinate2D, category:String, limit:Int) {
        self.placesForSearch = nil
        yelpService.getYelpData(coordinates: coordinates, category: category, limit: limit) { (uncleanedModel) in
            var cleanedDataGroup:[CleanYelpBulkPlaceModel] = []
            for place in uncleanedModel.businesses{
                
                let rating = self.getStarImage(with: place.rating ?? 0)
                let price = place.price ?? ""
                let phone = place.phone ?? ""
                let id = place.id ?? ""
                let category = place.categories?.first?.title ?? ""
                let reviewCount = place.review_count ?? 0
                let name = place.name ?? ""
                let url = place.url ?? ""
                let image = self.getImage(url: place.image_url)
                let address = "\(place.location?.address1 ?? ""), \(place.location?.address2 ?? ""), \(place.location?.city ?? ""), \(place.location?.state ?? ""), \(place.location?.country ?? "")"
                
                let cleanData:CleanYelpBulkPlaceModel = CleanYelpBulkPlaceModel(rating: rating, price: price, phone: phone, id: id, category: category, reviewCount: reviewCount, name: name, url: url, image: image, adress: address)
                
                cleanedDataGroup.append(cleanData)
            }
            DispatchQueue.main.async {
                self.placesForSearch = cleanedDataGroup
            }
        }
    }
}

//MARK: Category Functions
extension TrippyViewModel{
    
    func getSystemName(for category:String) -> String {
        switch category {
        case "Search":
            return "magnifyingglass"
        case "Hotels":
            return "house"
        case "Shopping":
            return "cart"
        case "Food":
            return "scroll"
        case "Museums":
            return "building.columns"
        case "Tours":
            return "bus"
        case "Beaches":
            return "sun.dust"
        case "Theme Parks":
            return "tram"
        case "Activities":
            return "person.3"
        case "Spas":
            return "eyebrow"
        case "Yoga":
            return "lungs"
        case "Parks":
            return "leaf"
        case "Zoos":
            return "tortoise"
        case "Aquariums":
            return "drop"
        case "Cinema":
            return "play.rectangle"
        default:
            return "camera"
        }
    }
    func getCatagoryAlias(with catagoryName: String) -> String {
        switch catagoryName {
        case "Hotels":
            return "hotels"
        case "Shopping":
            return "shopping"
        case "Food":
            return "food"
        case "Museums":
            return "museums"
        case "Tours":
            return "tours"
        case "Beaches":
            return "beaches"
        case "Theme Parks":
            return "amusementparks"
        case "Activities":
            return "active"
        case "Spas":
            return "beautysvc"
        case "Yoga":
            return "yoga"
        case "Parks":
            return "parks"
        case "Zoos":
            return "zoos"
        case "Aquariums":
            return "aquariums"
        case "Cinema":
            return "movietheaters"
        default:
            return ""
        }
    }
}

