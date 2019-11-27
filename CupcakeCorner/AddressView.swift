//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Thai Nguyen on 11/26/19.
//  Copyright © 2019 Thai Nguyen. All rights reserved.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order: Order
    
    
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.orderDetails.name)
                TextField("Street Address", text: $order.orderDetails.streetAddress)
                TextField("City", text: $order.orderDetails.city)
                TextField("Zip", text: $order.orderDetails.zip)
            }
            
            Section {
                NavigationLink(destination: CheckoutView(order: order)) {
                    Text("Check out")
                }
            }
            .disabled(order.orderDetails.hasValidAddress == false)
        }
        .navigationBarTitle("Delivery details", displayMode: .inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: Order())
    }
}
