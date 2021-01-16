//
//  Product.swift
//  EcoStore
//
//  Created by Anshay Saboo on 1/15/21.
//

import Foundation

// A Product represents a item that is listed for sale on the store
class Product {
    var name = ""
    var price = 0.0
    var description = ""
    var tags: [String] = []
    var charityName = ""
    var percentDonated = 0.0
}
