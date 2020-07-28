//
//  YelpService.swift
//  Trippy Swift UI
//
//  Created by Jonathan Morris on 7/23/20.
//

import Foundation
import MapKit
struct YelpService {
    func getYelpData(coordinates:CLLocationCoordinate2D, category:String, limit:Int, completion: @escaping (YelpCatergoryModel) -> Void) {
        
        var stringURL = "https://api.yelp.com/v3/businesses/search?categories=\(category)&latitude=\(coordinates.latitude)&longitude=\(coordinates.longitude)&limit=\(limit)"
        stringURL = stringURL.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
        let url = URL(string: stringURL)!
        var request = URLRequest(url: url)
        request.setValue("Bearer \(YelpAPIKey().key)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let d = data else{
                print(error!)
                return
            }
            do{
                let result = try JSONDecoder().decode(YelpCatergoryModel.self, from: d)
                completion(result)
            }catch{
                print(error)
            }
        }.resume()
    }
}
