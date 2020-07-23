//
//  AddTripView.swift
//  Trippy Swift UI
//
//  Created by Jonathan Morris on 7/21/20.
//

import SwiftUI
import MapKit

struct AddTripView: View {
    @EnvironmentObject var trippyViewModel:TrippyViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @Binding var fromDate:Date
    @Binding var toDate:Date
    @Binding var cityName:String
    
    @State private var errorMessagePresenting:Bool = false
    @State private var errorMessage = ""
    
    func showAlert(with text:String){
        errorMessage = text
        errorMessagePresenting = true
    }
    
    var body: some View {
        Form {
            Section(header: Text("City Name").padding(.top, 20)){
                TextField("Enter Name", text: $cityName)
            }
            
            Section(header: Text("Date")) {
                VStack(alignment:.leading) {
//                    DatePicker("From", selection: $fromDate,displayedComponents: .date)
//                    DatePicker("To     ", selection: $toDate,displayedComponents: .date)
                }
                .padding([.top,.bottom])
            }
        }
        .navigationTitle("Add Trip")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing: Button(action: {
            guard cityName != "" else{
                showAlert(with: "Enter a City Name")
                return
            }
            CLGeocoder().geocodeAddressString(cityName) { (placemarks, error) in
                if placemarks?.first?.location?.coordinate != nil {
                    trippyViewModel.addTrip(cityName: cityName, fromDate: fromDate, toDate: toDate)
                    cityName = ""
                    fromDate = Date()
                    toDate = Date()
                    presentationMode.wrappedValue.dismiss()
                }else{
                    showAlert(with: "Could Not Find The City")
                }
            }
            
        }, label: {
            Text("Done")
        }))
        .alert(isPresented: $errorMessagePresenting) {
            Alert(title: Text(errorMessage))
        }
        
    }
}

struct AddTripView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            AddTripView(fromDate: .constant(Date()),toDate: .constant(Date()),cityName: .constant(""))
                .environmentObject(TrippyViewModel())
                .environment(\.colorScheme, .light)
        }
    }
}
