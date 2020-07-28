//
//  CategoryView.swift
//  Trippy Swift UI
//
//  Created by Jonathan Morris on 7/28/20.
//

import SwiftUI

struct CategoryView: View {
    @EnvironmentObject var trippyViewModel:TrippyViewModel
    @Environment(\.colorScheme) var colorScheme
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var body: some View {
        NavigationView{
            LazyVGrid(columns: columns) {
                ForEach(trippyViewModel.categoriesAvailable, id: \.self) { trip in
                    #warning("Need to add the destination")
                    NavigationLink(
                        destination: Text("Destination"),
                        label: {
                            VStack{
                                Image(systemName: trippyViewModel.getSystemName(for: trip))
                                    .renderingMode(.original)
                                    .font(.title)
                                    .padding(.bottom)
                                Text(trip)
                                    .foregroundColor(colorScheme == .dark ? .white:.black)
                                    .multilineTextAlignment(.center)
                            }.padding()
                        })
                }
            }
            .navigationTitle("Select Category")
            .navigationBarTitleDisplayMode(.inline)
        }
        
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView()
            .environmentObject(TrippyViewModel())
    }
}
