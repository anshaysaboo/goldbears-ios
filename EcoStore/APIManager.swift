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
    private static let BASE_URL = "http://fa3e10d5681f.ngrok.io/"
    
    // Returns a formatted API URL for the given path
    private static func getURL(_ path: String) -> String {
        return BASE_URL + path
    }
    
}
