//
//  DeatailView.swift
//  Trippy Swift UI
//
//  Created by Jonathan Morris on 7/29/20.
//

import SwiftUI
import MapKit

struct PlaceDeatailView: View {
    @EnvironmentObject var trippyViewModel:TrippyViewModel
    @State var isAdded = false
    @Environment(\.openURL) var openURL
    
    var trip:Trip? = nil
    var id:String?
    
    var body: some View {
        VStack(alignment:.leading){
            if trippyViewModel.businessDetails != nil{
                let place = trippyViewModel.businessDetails!
                
                ScrollView(.horizontal){
                    HStack{
                        ImageView(image: place.photos[0])
                        ImageView(image: place.photos[1])
                        ImageView(image: place.photos[2])
                    }
                }
                .frame(height: 400, alignment: .center)
                
                VStack(alignment:.leading){
                    HStack{
                        Text(place.name)
                            .font(.largeTitle)
                            .lineSpacing(0)
                        Text(place.price)
                            .font(.largeTitle)
                            .foregroundColor(Color(#colorLiteral(red: 0.3959157467, green: 0.6456650496, blue: 0.2190004587, alpha: 1)))
                            .fontWeight(.bold)
                    }
                    Text(place.address)
                        .font(.body)
                    Text(place.phone)
                        .font(.body)
                    HStack{
                        Image(uiImage: place.ratingImage)
                        Text(String(place.reviewCount))
                    }
                }.padding(.horizontal)
                
                Spacer()
                
                HStack{
                    Button(action: {
                        //"This is the call button"
                        let dash = CharacterSet(charactersIn: "-")
                        
                        let cleanString = place.phone.trimmingCharacters(in: dash)
                        
                        let tel = "tel://" 
                        let formattedString = tel + cleanString
                        let url: NSURL = URL(string: formattedString)! as NSURL
                        UIApplication.shared.open(url as URL)
                        
                    }, label: {
                        Image(systemName: "phone")
                            .resizable()
                            .font(.largeTitle)
                            .aspectRatio(contentMode: .fit)
                    })
                    .buttonStyle(PlainButtonStyle())
                    Spacer()
                    Button(action: {
                        //This is the directions button
                        let geocoder = CLGeocoder()
                        let str = place.address
                        geocoder.geocodeAddressString(str) { (placemarksOptional, error) -> Void in
                            if let placemarks = placemarksOptional {
                                if (placemarks.first?.location) != nil {
                                    let string = "?sdaddr=\(placemarks.first!.postalCode!)&daddr=\(placemarks.first!.name!)"
                                    let query = string.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
                                    let path = "http://maps.apple.com/" + query
                                    if let url = URL(string: path) {
                                        openURL(url)
                                    }
                                }
                            }
                        }
                    }, label: {
                        Image(systemName: "location")
                            .resizable()
                            .font(.largeTitle)
                            .aspectRatio(contentMode: .fit)
                    })
                    .buttonStyle(PlainButtonStyle())
                    Spacer()
                    Button(action: {
                        withAnimation{
                            isAdded.toggle()
                        }
                    }, label: {
                        Image(systemName: isAdded ? "checkmark":"plus")
                            .resizable()
                            .font(.largeTitle)
                            .aspectRatio(contentMode: .fit)
                    })
                    .buttonStyle(PlainButtonStyle())
                    .onAppear{
                        if trippyViewModel.isPlaceAdded(placeName: place.name, trip: trip ?? trippyViewModel.selectedTrip){
                            isAdded = true
                        }else{
                            isAdded = false
                        }
                    }
                    Spacer()
                    Button(action: {
                        //This is the Yelp Button
                        openURL(place.url)
                    }, label: {
                        Image(uiImage: #imageLiteral(resourceName: "yelpLogo"))
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    })
                    .buttonStyle(PlainButtonStyle())
                }
                .padding(.horizontal)
                .frame(height:60)
                
                .onDisappear{
                    if isAdded && !trippyViewModel.isPlaceAdded(placeName: place.name, trip: trip ?? trippyViewModel.selectedTrip){
                        trippyViewModel.addPlaceToSelectedTrip(business: place)
                    }else if !isAdded && trippyViewModel.isPlaceAdded(placeName: place.name, trip: trip ?? trippyViewModel.selectedTrip){
                        trippyViewModel.removePlace(placeName: place.name)
                    }
                    isAdded = false
                }
                Spacer()
                    
            }
            else{
                ProgressView()
            }
        }
        .onAppear{
            trippyViewModel.businessDetails = nil
            if id != nil{
                trippyViewModel.getYelpData(coordinates: nil, category: nil, limit: nil, buisnessId: id!)
            }else{
                trippyViewModel.getYelpData(coordinates: nil, category: nil, limit: nil, buisnessId: trippyViewModel.selectedID)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DeatailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            PlaceDeatailView(id: "WavvLdfdP6g8aZTtbBQHTw")
                .environmentObject(TrippyViewModel())
        }
        .previewDevice("iPhone 11 Pro")
    }
}
