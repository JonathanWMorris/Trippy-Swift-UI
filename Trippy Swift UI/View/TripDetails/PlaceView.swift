//
//  PlaceView.swift
//  Trippy Swift UI
//
//  Created by Jonathan Morris on 7/23/20.
//

import SwiftUI

struct PlaceView: View {
    @Environment(\.colorScheme) var colorScheme
    var place:CleanYelpBulkPlaceModel
    var body: some View {
        HStack{
            ImageView(image: place.image)
                .frame(width: 100, height:100)
                .cornerRadius(10)
                .clipped()
            
            VStack(alignment:.leading){
                HStack{
                    Text(place.name)
                        .font(.headline)
                        .lineSpacing(0)
                    Text(place.price)
                        .foregroundColor(Color(#colorLiteral(red: 0.3959157467, green: 0.6456650496, blue: 0.2190004587, alpha: 1)))
                        .fontWeight(.bold)
                }
                Text(place.address)
                    .font(.caption2)
                Image(uiImage: place.ratingImage)
            }
            Spacer()
        }
        .frame(height:100)
        .padding(.leading,5)
    }
    
}

struct PlaceView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PlaceView(place: CleanYelpBulkPlaceModel(
                        ratingImage: #imageLiteral(resourceName: "4"), price: "$$",
                        id: "Fast Food", reviewCount: 10000, name: "Jonathan's Burger Place",
                        image: #imageLiteral(resourceName: "placeholder"), address: "Paris Dr. , California, US"))
                .environment(\.colorScheme, .light)
                .previewLayout(.sizeThatFits)
            PlaceView(place: CleanYelpBulkPlaceModel(
                        ratingImage: #imageLiteral(resourceName: "4"), price: "$$", id: "",
                        reviewCount: 10000, name: "Jonathan's Burger Place", image: #imageLiteral(resourceName: "placeholder"), address: "Paris Dr. , California, US"))
                .previewLayout(.sizeThatFits)
                .environment(\.colorScheme, .dark)
                .background(Color.black)
        }
    }
}
