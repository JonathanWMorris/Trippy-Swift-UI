//
//  AddTripView.swift
//  Trippy Swift UI
//
//  Created by Jonathan Morris on 7/21/20.
//

import SwiftUI

struct AddTripView: View {
    
    @Binding var fromDate:Date
    @Binding var toDate:Date
    @Binding var cityName:String
    @State private var errorMessagePresenting:Bool = false
    
    var body: some View {
        Form {
            Section(header: Text("City Name").padding(.top, 20)){
                TextField("Enter Name", text: $cityName)
            }
            
            Section(header: Text("Date")) {
                VStack(alignment:.leading) {
                    DatePicker("From", selection: $fromDate,displayedComponents: .date)
                    DatePicker("To     ", selection: $toDate,displayedComponents: .date)
                }
                .frame(height: 100, alignment: .center)
                .font(.body)
                .padding(.all, 10)
                Spacer()
            }
        }
        .navigationTitle("Add Trip")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing: Button(action: {
            if toDate.timeIntervalSince1970 > fromDate.timeIntervalSince1970{
                
            }else{
                errorMessagePresenting = true
            }
        }, label: {
            Text("Done")
        }))
        .alert(isPresented: $errorMessagePresenting) {
            Alert(title: Text("Please Check your Date"))
        }
    }
}

struct AddTripView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            AddTripView(fromDate: .constant(Date()),toDate: .constant(Date()),cityName: .constant(""))
        }
    }
}
