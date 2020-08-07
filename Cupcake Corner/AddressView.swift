//
//  AddressView.swift
//  Cupcake Corner
//
//  Created by Mark Chen on 2020/8/2.
//  Copyright © 2020 Mark Chen. All rights reserved.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order: Order
    
    var body: some View {
 
            Form {
                Section {
                    TextField("Address", text: $order.address)
                    TextField("Country", text: $order.country)
                    TextField("zip code", text: $order.zipcode)
                }
                
                Section {
                    NavigationLink(destination: Checkout(order: order)) {
                        Text("check out")
                    }
                }.disabled(order.isAddressValid == false)
            }
            .navigationBarTitle("delivery details", displayMode: .inline)
        
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: Order())
    }
}
