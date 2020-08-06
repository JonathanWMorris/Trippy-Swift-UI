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
    @Published var allTrips:Results<Trip>?
    @Published var selectedTrip:Trip = Trip()
    
    @Published var categorySelected = ""
    @Published var selectedID = ""
    @Published var placesForSearch:[CleanYelpBulkPlaceModel]? = nil
    @Published var businessDetails:CleanedBusinessDetailsModel? = nil
    
    @Published var totalObjectsToFetch = 1.0
    @Published var objectsFetched = 0.0
    
    let categoriesAvailable: [String] = [
        "Search","Hotels", "Shopping","Food", "Museums",
        "Tours", "Beaches", "Theme Parks","Activities","Spas",
        "Yoga", "Parks", "Zoos", "Aquariums", "Cinema"
    ]
    
    init() {
        allTrips = realm.objects(Trip.self)
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
                self.allTrips = self.realm.objects(Trip.self)
            }
            
        }
    }
    func isPlaceAdded(placeName:String) -> Bool {
        let places = selectedTrip.places
        for place in places{
            if place.name == placeName{
                return true
            }
        }
        
        return false
    }
    
    func fetchPlacesForCurrentTrip(trip:Trip) {
        DispatchQueue.main.async{
            self.selectedTrip = trip
        }
    }
    
    func addPlaceToSelectedTrip(business:CleanedBusinessDetailsModel) {
        let place = Place()
        place.id = business.id
        place.name = business.name
        place.imageURL = business.imageURL
        place.photo1 = business.photosURL[0]
        place.photo2 = business.photosURL[1]
        place.photo3 = business.photosURL[2]
        place.rating = business.rating
        place.price = business.price
        place.reviewCount = business.reviewCount
        place.phone = business.phone
        place.url = business.url.absoluteString
        place.address = business.address
        place.latitude = business.coordinates.latitude
        place.longitude = business.coordinates.longitude
        place.timeAdded = Date()
        
        DispatchQueue.main.async {
            try! self.realm.write{
                self.selectedTrip.places.append(place)
            }
        }
    }
    
    func useCachedData(place:Place) {
        let id = place.id
        let name = place.name
        let image = self.getImage(url: place.imageURL)
        let imageURL = place.imageURL
        let url = URL(string: place.url)!
        let urlString = place.url
        let phone = place.phone
        let reviewCount = place.reviewCount
        let ratingImage = self.getRatingImage(with: place.rating)
        let rating = place.rating
        let address = place.address
        let coordinates = CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude)
        let photosURL = [place.photo1, place.photo2, place.photo3]
        var photos:[UIImage] = [#imageLiteral(resourceName: "placeholder"),#imageLiteral(resourceName: "placeholder"),#imageLiteral(resourceName: "placeholder")]
        let UNphotos = photosURL
        photos.removeAll()
        for photo in UNphotos {
            photos.append(self.getImage(url: photo))
        }
        let price = place.price
        
        let cleanedBuisness = CleanedBusinessDetailsModel(id: id, name: name, image: image, imageURL: imageURL,
                                                          url: url, urlString: urlString, phone: phone,
                                                          reviewCount: reviewCount, ratingImage: ratingImage, rating: rating, address: address,
                                                          coordinates: coordinates, photos: photos, photosURL: photosURL, price: price)
        DispatchQueue.main.async {
            self.businessDetails = cleanedBuisness
        }
    }
    
    func removePlace(placeName:String) {
        let places = selectedTrip.places
        for place in places{
            if place.name == placeName{
                DispatchQueue.main.async {
                    try! self.realm.write{
                        self.realm.delete(place)
                    }
                }
            }
        }
    }
    
    
    func getYelpData(coordinates:CLLocationCoordinate2D?, category:String?, limit:Int?, buisnessId:String?) {
        
        yelpService.getYelpDataWithCategory(
            coordinates: coordinates, buisnessId: buisnessId, category: category, limit: limit) { (uncleanedBulk, uncleanedBusiness)  in
            if uncleanedBulk != nil{
                DispatchQueue.main.async {
                    self.placesForSearch = nil
                    self.totalObjectsToFetch = Double(uncleanedBulk!.businesses.count)
                    self.objectsFetched = 0.0
                }
                var cleanedDataGroup:[CleanYelpBulkPlaceModel] = []
                for place in uncleanedBulk!.businesses{
                    DispatchQueue.main.async {
                        self.objectsFetched += 1.0
                    }
                    let ratingImage = self.getRatingImage(with: place.rating ?? 0)
                    let price = place.price ?? ""
                    let id = place.id ?? ""
                    let reviewCount = place.review_count ?? 0
                    let name = place.name ?? ""
                    let image = self.getImage(url: place.image_url)
                    let address = self.getAddress(address1: place.location?.address1, address2: place.location?.address2,
                                                  city: place.location?.city, state: place.location?.state, country: place.location?.country,
                                                  zipCode: place.location?.zip_code)
                    
                    let cleanData:CleanYelpBulkPlaceModel =
                        CleanYelpBulkPlaceModel(ratingImage: ratingImage, price: price,
                                                id: id, reviewCount: reviewCount,
                                                name: name, image: image, address: address)
                    
                    cleanedDataGroup.append(cleanData)
                }
                DispatchQueue.main.async {
                    self.placesForSearch = cleanedDataGroup
                }
                
            } else if uncleanedBusiness != nil{
                DispatchQueue.main.async {
                    self.businessDetails = nil
                }
                
                let id = uncleanedBusiness?.id ?? ""
                let name = uncleanedBusiness?.name ?? ""
                let image = self.getImage(url: uncleanedBusiness?.image_url)
                let imageURL = uncleanedBusiness?.image_url ?? ""
                let url = URL(string: uncleanedBusiness?.url ?? "https://www.google.com")!
                let urlString = uncleanedBusiness?.url ?? ""
                let phone = uncleanedBusiness?.phone ?? ""
                let reviewCount = uncleanedBusiness?.review_count ?? 0
                let ratingImage = self.getRatingImage(with: uncleanedBusiness?.rating ?? 0.0)
                let rating = uncleanedBusiness?.rating ?? 0.0
                let address = self.getAddress(address1: uncleanedBusiness?.location.address1, address2: uncleanedBusiness?.location.address2,
                                              city: uncleanedBusiness?.location.city, state: uncleanedBusiness?.location.state,
                                              country: uncleanedBusiness?.location.country, zipCode: uncleanedBusiness?.location.zip_code)
                
                let coordinates = CLLocationCoordinate2D(latitude: uncleanedBusiness!.coordinates!.latitude, longitude: uncleanedBusiness!.coordinates!.longitude)
                let photosURL = uncleanedBusiness?.photos ?? [""]
                var photos:[UIImage] = [#imageLiteral(resourceName: "placeholder"),#imageLiteral(resourceName: "placeholder"),#imageLiteral(resourceName: "placeholder")]
                if let UNphotos = uncleanedBusiness?.photos{
                    photos.removeAll()
                    for photo in UNphotos {
                        photos.append(self.getImage(url: photo))
                    }
                }
                let price = uncleanedBusiness?.price ?? ""
                
                let cleanedBuisness = CleanedBusinessDetailsModel(id: id, name: name, image: image, imageURL: imageURL,
                                                                  url: url, urlString: urlString, phone: phone,
                                                                  reviewCount: reviewCount, ratingImage: ratingImage, rating: rating, address: address,
                                                                  coordinates: coordinates, photos: photos, photosURL: photosURL, price: price)
                
                DispatchQueue.main.async {
                    self.businessDetails = cleanedBuisness
                }
            }
        }
    }
}

//MARK: Small Get Methods
extension TrippyViewModel{
    func getFormattedDate(with date:Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        return dateFormatter.string(from: date)
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
    func getRatingImage(with number:Double) -> UIImage {
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
        case 3.5:
            return #imageLiteral(resourceName: "3_half")
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
    func getAddress(address1:String?,address2:String?,city:String?,state:String?,country:String?,zipCode:String?) -> String {
        if address2 != ""{
            return "\(address1 ?? ""), \(address2 ?? ""), \(city ?? ""), \(state ?? ""), \(country ?? ""), \(zipCode ?? "")"
        }else{
            return "\(address1 ?? ""), \(city ?? ""), \(state ?? ""), \(country ?? ""), \(zipCode ?? "")"
        }
        
    }
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

