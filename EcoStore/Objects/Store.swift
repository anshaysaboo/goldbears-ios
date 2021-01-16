//
//  Store.swift
//  EcoStore
//
//  Created by Anshay Saboo on 1/16/21.
//

import Foundation
import SwiftyJSON

// A Store represents a store owned by a user that has a collection of products
class Store {
    var title = ""
    var description = ""
    var imageUrl = ""
    var owner = ""
    
    var products: [Product] = []
    
    init(json: JSON) {
        self.title = json["title"].string!
        self.description = json["description"].string!
        
        if let imageUrl = json["imageUrl"].string {
            self.imageUrl = imageUrl
        }
        
        if let owner = json["ownerId"].dictionary?["username"]?.string {
            self.owner = owner
        }
        
        if let products = json["products"].array {
            for json: JSON in products {
                let product = Product(json: json)
                product.storeId = json["_id"].string!
                product.storeTitle = self.title
                self.products.append(product)
            }
        }
    }
}
