//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Thai Nguyen on 11/26/19.
//  Copyright © 2019 Thai Nguyen. All rights reserved.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: Order
    
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    
    @State private var showingError = false
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack {
                    Image("cupcakes")
                    .resizable()
                    .scaledToFit()
                        .frame(width: geo.size.width)
                    
                    Text("Your total is $\(self.order.orderDetails.cost, specifier: "%.2f")")
                        .font(.title)
                    
                    Button("Place Order") {
                        self.placeOrder()
                    }
                .padding()
                }
                
            }
        }
        .navigationBarTitle("Checkout", displayMode: .inline)
            .alert(isPresented: $showingError) {
                Alert(title: Text("Error!"), message: Text("Failed to place order"), dismissButton: .default(Text("OK")))
            }
        .alert(isPresented: $showingConfirmation) {
            Alert(title: Text("Thank you"), message: Text(confirmationMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    func placeOrder() {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode order")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown error")")
                
                self.showingError = true
                
                return
            }
            
            if let decodedOrder = try? JSONDecoder().decode(Order.self, from: data) {
                self.confirmationMessage = "Your order for \(decodedOrder.orderDetails.quantity) x\(OrderDetails.types[decodedOrder.orderDetails.type].lowercased()) cupcakes is on its way!"
                self.showingConfirmation = true
            } else {
                print("Invalid response from server")
            }
    
        }.resume()
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
