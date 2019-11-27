//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Thai Nguyen on 11/26/19.
//  Copyright © 2019 Thai Nguyen. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var order = Order()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your cake type", selection: $order.orderDetails.type) {
                        ForEach(0..<OrderDetails.types.count, id: \.self) {
                            Text(OrderDetails.types[$0])
                        }
                    }
                    
                    Stepper(value: $order.orderDetails.quantity, in: 3...20) {
                        Text("Number of cakes: \(order.orderDetails.quantity)")
                    }
                }
                
                Section {
                    Toggle(isOn: $order.orderDetails.specialRequestEnabled.animation()) {
                        Text("Any special requests?")
                    }
                    
                    if order.orderDetails.specialRequestEnabled {
                        Toggle(isOn: $order.orderDetails.extraFrosting) {
                            Text("Add extra frosting")
                        }
                        
                        Toggle(isOn: $order.orderDetails.addSprinkles) {
                            Text("Add extra sprinkles")
                        }
                    }
                }
                
                Section {
                    NavigationLink(destination: AddressView(order: order)) {
                        Text("Delivery details")
                    }
                }
            }
        .navigationBarTitle("Cupcake Corner")
        }
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
