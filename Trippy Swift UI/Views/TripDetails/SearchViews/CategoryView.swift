//
//  CategoryView.swift
//  Trippy Swift UI
//
//  Created by Jonathan Morris on 7/28/20.
//

import SwiftUI
import MapKit

struct CategoryView: View {
    @EnvironmentObject var trippyViewModel:TrippyViewModel
    @Environment(\.colorScheme) var colorScheme
    
    var coordinates:CLLocationCoordinate2D
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView{
            LazyVGrid(columns: columns) {
                ForEach(trippyViewModel.categoriesAvailable, id: \.self) { trip in
                    NavigationLink(
                        destination: SearchView(coordinates: coordinates, category: trip),
                        label: {
                            VStack{
                                Image(systemName: trippyViewModel.getSystemName(for: trip))
                                    .font(.title)
                                    .padding(.bottom)
                                Text(trip)
                                    .multilineTextAlignment(.center)
                            }.padding()
                        })
                        .buttonStyle(PlainButtonStyle())
                }
            }
            .navigationTitle("Select Category")
        }
    }
    
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView(coordinates: CLLocationCoordinate2D())
            .environmentObject(TrippyViewModel())
    }
}
