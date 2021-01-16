//
//  APIManager.swift
//  EcoStore
//
//  Created by Anshay Saboo on 1/16/21.
//

import Foundation
import Alamofire
import SwiftyJSON

// An APIManager contains static methods that fetch data from the app server
class APIManager {
    private static let BASE_URL = "http://fa3e10d5681f.ngrok.io"
    
    // Returns a formatted API URL for the given path
    private static func getURL(_ path: String) -> String {
        return BASE_URL + "/api" + path
    }
    
    // Returns a list of Products for a given search query
    // @param query The query string for which to find products
    static func searchForProducts(query: String, completion: @escaping ([Product], Bool) -> Void) {
        AF.request(getURL("/products/"), method: .get, parameters: ["query" : query]).responseData { (response) in
            if response.error != nil {
                completion([], false)
                return
            }
            
            let json = try! JSON(data: response.data!)
            guard let productsJSON = json.array else {
                completion([], false)
                return
            }
            
            var products: [Product] = []
            for prodJson: JSON in productsJSON {
                products.append(Product(json: prodJson))
            }
            
            completion(products, true)
        }
    }
    
}
