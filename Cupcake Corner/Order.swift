//
//  Order.swift
//  Cupcake Corner
//
//  Created by Mark Chen on 2020/8/2.
//  Copyright © 2020 Mark Chen. All rights reserved.
//

import Foundation

class Order: ObservableObject, Codable {
    
    enum CodingKeys: CodingKey {
        case type, quantity, specialRequestEnabled, extraFroating, addSprinkles, address, country, zipcode
    }
    
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    @Published var type = 0
    @Published var quantity = 3
    
    @Published var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
               extraFroating = false
                addSprinkles = false
            }
        }
    }
    @Published var extraFroating = false
    @Published var addSprinkles = false
    
    @Published var address = ""
    @Published var country = ""
    @Published var zipcode = ""
    
    var isAddressValid: Bool {
        if address.isEmpty || country.isEmpty || zipcode.isEmpty {
            return false
        } else {
            return true
        }
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        type = try container.decode(Int.self, forKey: .type)
        quantity = try container.decode(Int.self, forKey: .quantity)
        extraFroating = try container.decode(Bool.self, forKey: .extraFroating)
        addSprinkles = try container.decode(Bool.self, forKey: .addSprinkles)
        address = try container.decode(String.self, forKey: .address)
        country = try container.decode(String.self, forKey: .country)
        zipcode = try container.decode(String.self, forKey: .zipcode)
        specialRequestEnabled = try container.decode(Bool.self, forKey: .specialRequestEnabled)
    }
    
    init() {}
    
    func encode(to enconder: Encoder) throws {
        var container = enconder.container(keyedBy: CodingKeys.self)
        
        try container.encode(type, forKey: .type)
        try container.encode(quantity, forKey: .quantity)
        try container.encode(specialRequestEnabled, forKey: .specialRequestEnabled)
        try container.encode(extraFroating, forKey: .extraFroating)
        try container.encode(addSprinkles, forKey: .addSprinkles)
        try container.encode(address, forKey: .address)
        try container.encode(country, forKey: .country)
        try container.encode(zipcode, forKey: .zipcode)
    }
}
