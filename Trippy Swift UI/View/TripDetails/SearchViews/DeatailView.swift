//
//  DeatailView.swift
//  Trippy Swift UI
//
//  Created by Jonathan Morris on 7/29/20.
//

import SwiftUI
import MapKit

struct DeatailView: View {
    @EnvironmentObject var trippyViewModel:TrippyViewModel
    @State var isAdded = false
    @Environment(\.colorScheme) var colorScheme
    var id:String
    
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
                    Text(place.displayPhone)
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
                        #warning("set the call button")
                    }, label: {
                        Image(systemName: "phone")
                            .resizable()
                            .renderingMode(.original)
                            .font(.largeTitle)
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(colorScheme == .dark ? .white:.black)
                    })
                    Spacer()
                    Button(action: {
                        //This is the directions button
                        #warning("set the directions button")
                    }, label: {
                        Image(systemName: "location")
                            .resizable()
                            .renderingMode(.original)
                            .font(.largeTitle)
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(colorScheme == .dark ? .white:.black)
                    })
                    Spacer()
                    Button(action: {
                        //This is the Yelp Button
                        #warning("set the yelp button")
                    }, label: {
                        Image(uiImage: #imageLiteral(resourceName: "yelpLogo"))
                            .renderingMode(.original)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    })
                }
                .padding(.horizontal)
                .frame(height:60)
                
                Spacer()
            }
            else{
                ProgressView()
            }
        }
        .onAppear{
            trippyViewModel.businessDetails = nil
            trippyViewModel.getYelpData(coordinates: nil, category: nil, limit: nil, buisnessId: id)
        }
        .navigationBarItems(trailing: Button(action: {
            //The add function
            #warning("set the Add Function")
            withAnimation{
                isAdded.toggle()
            }
        }, label: {
            Image(systemName: isAdded ? "checkmark":"plus")
                .font(.title)
                .animation(.spring())
        }))
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DeatailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            DeatailView(id: "WavvLdfdP6g8aZTtbBQHTw")
        }
        .previewDevice("iPhone 11 Pro")
    }
}
