//
//  SearchView.swift
//  Trippy Swift UI
//
//  Created by Jonathan Morris on 7/29/20.
//

import SwiftUI
import MapKit

struct SearchView: View {
    @State var searchBarText = ""
    @EnvironmentObject var trippyViewModel: TrippyViewModel
    @State var itemLimit = 40
    
    var coordinates:CLLocationCoordinate2D
    var category:String
    
    var body: some View {
        ScrollView{
            SearchBarView(text: $searchBarText)
            
            if trippyViewModel.placesForSearch != nil{
                LazyVStack{
                    ForEach(trippyViewModel.placesForSearch!){place in
                        NavigationLink(
                            destination: PlaceDeatailView(id: place.id),
                            label: {
                                PlaceView(place: place)
                            })
                            .buttonStyle(PlainButtonStyle())
                            .animation(.default)
                    }
                }.animation(.default)
            }else{
                ProgressView("Loading",value:trippyViewModel.objectsFetched,total:trippyViewModel.totalObjectsToFetch)
                    .padding(.horizontal)
                    .animation(.default)
            }
            Spacer()
        }
        .onAppear(){
            if trippyViewModel.categorySelected != category{
                trippyViewModel.categorySelected = category
                trippyViewModel.placesForSearch?.removeAll()
                trippyViewModel.objectsFetched = 0.0
                trippyViewModel.totalObjectsToFetch = 1.0
                let alias = trippyViewModel.getCatagoryAlias(with: category)
                trippyViewModel.getYelpData(coordinates: coordinates, category: alias, limit: itemLimit, buisnessId: nil)
            }
        }
        .navigationTitle(category)
    }
}



struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(coordinates:CLLocationCoordinate2D(), category: "Food")
            .environmentObject(TrippyViewModel())
    }
}

