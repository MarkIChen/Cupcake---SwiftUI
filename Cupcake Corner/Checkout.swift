//
//  Checkout.swift
//  Cupcake Corner
//
//  Created by Mark Chen on 2020/8/2.
//  Copyright © 2020 Mark Chen. All rights reserved.
//

import SwiftUI

struct Checkout: View {
    @ObservedObject var order: Order
    @State private var confirmMessage = ""
    @State private var showingConfirmation = false
    var body: some View {
        
        Button("place Order") {
            self.placeOrder()
        }
        .navigationBarTitle("Check Out", displayMode: .inline)
        .alert(isPresented: $showingConfirmation) {
            Alert(title: Text("Thank you!"), message: Text(confirmMessage), dismissButton: .default(Text("OK")))
        }
      
    }
    
    func placeOrder() {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("failed to encode order")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded

        URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            guard let data = data else {
                print("no data in response")
                return
            }
            if let _ = try? JSONDecoder().decode(Order.self, from:
                data) {
                self.confirmMessage = "Upload Success."
                self.showingConfirmation = true
            } else {
                print("Invalid response!")
            }
        }.resume()
    }
}

struct Checkout_Previews: PreviewProvider {
    static var previews: some View {
        Checkout(order: Order())
    }
}
