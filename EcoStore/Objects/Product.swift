//
//  Product.swift
//  EcoStore
//
//  Created by Anshay Saboo on 1/15/21.
//

import Foundation
import SwiftyJSON

// A Product represents a item that is listed for sale on the store
class Product {
    var title = ""
    var description = ""
    var price = 0.0
    var tags: [String] = []
    var charity = ""
    var percentDonated = 0.0
    var imageUrl = ""
    
    var storeTitle = ""
    var storeId = ""
    
    init(json: JSON) {
        self.title = json["title"].string!
        self.description = json["description"].string!
        self.price = json["price"].double!
        self.charity = json["charity"].string!
        self.percentDonated = json["percentToCharity"].double!
        for tagJson: JSON in json["tags"].array! {
            tags.append(tagJson.string!)
        }
        
        if let imageUrl = json["imageUrl"].string {
            self.imageUrl = imageUrl
        }
        
        if let storeJson = json["storeId"].dictionary {
            self.storeTitle = storeJson["title"]!.string!
            self.storeId = storeJson["_id"]!.string!
        }
    }
    
    // Returns true if we need to display an image for this Product
    func hasImage() -> Bool {
        return !imageUrl.isEmpty
    }
}
