//
//  Order.swift
//  CupcakeCorner
//
//  Created by Thai Nguyen on 11/27/19.
//  Copyright © 2019 Thai Nguyen. All rights reserved.
//

import Foundation

//class Order: ObservableObject, Codable {
//    enum CodingKeys: CodingKey {
//        case type, quantity, specialRequestEnabled, extraFrosting, addSprinkles, name, streetAddress, city, zip
//    }
//
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//
//        try container.encode(type, forKey: .type)
//        try container.encode(quantity, forKey: .quantity)
//        try container.encode(extraFrosting, forKey: .extraFrosting)
//        try container.encode(addSprinkles, forKey: .addSprinkles)
//
//        try container.encode(name, forKey: .name)
//        try container.encode(streetAddress, forKey: .streetAddress)
//        try container.encode(city, forKey: .city)
//        try container.encode(zip, forKey: .zip)
//    }
//
//    required init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//
//        type = try container.decode(Int.self, forKey: .type)
//        quantity = try container.decode(Int.self, forKey: .quantity)
//
//        extraFrosting = try container.decode(Bool.self, forKey: .extraFrosting)
//        addSprinkles = try container.decode(Bool.self, forKey: .addSprinkles)
//
//        name = try container.decode(String.self, forKey: .name)
//        streetAddress = try container.decode(String.self, forKey: .streetAddress)
//        city = try container.decode(String.self, forKey: .city)
//        zip = try container.decode(String.self, forKey: .zip)
//    }
//
//    init() {}
//
//    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
//
//    @Published var type = 0
//    @Published var quantity = 3
//    @Published var specialRequestEnabled = false {
//        didSet {
//            if specialRequestEnabled == false {
//                extraFrosting = false
//                addSprinkles = false
//            }
//        }
//    }
//    @Published var extraFrosting = false
//    @Published var addSprinkles = false
//
//    @Published var name = ""
//    @Published var streetAddress = ""
//    @Published var city = ""
//    @Published var zip = ""
//
//    var hasValidAddress: Bool {
//        if !name.isValid() || !streetAddress.isValid() || !city.isValid() || !zip.isValid() {
//            return false
//        }
//
//        return true
//    }
//
//    var cost: Double {
//        var cost = Double(quantity) * 2
//
//        cost += (Double(type) / 2)
//
//        if extraFrosting {
//            cost += Double(quantity)
//        }
//
//        if addSprinkles {
//            cost += Double(quantity) / 2
//        }
//
//        return cost
//    }
//}

struct OrderDetails: Codable {
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    var type = 0
    var quantity = 3
    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    var hasValidAddress: Bool {
        if !name.isValid() || !streetAddress.isValid() || !city.isValid() || !zip.isValid() {
            return false
        }
        
        return true
    }
    
    var cost: Double {
        var cost = Double(quantity) * 2
        
        cost += (Double(type) / 2)
        
        if extraFrosting {
            cost += Double(quantity)
        }
        
        if addSprinkles {
            cost += Double(quantity) / 2
        }
        
        return cost
    }
}

class Order: ObservableObject, Codable {
    enum CodingKeys: CodingKey {
        case orderDetails
    }
    
    @Published var orderDetails: OrderDetails
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(orderDetails, forKey: .orderDetails)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        orderDetails = try container.decode(OrderDetails.self, forKey: .orderDetails)
    }
    
    init() {
        self.orderDetails = OrderDetails()
    }
}

extension String {
    func isValid() -> Bool {
        
        return self.replacingOccurrences(of: " ", with: "").count > 0
    }
}
