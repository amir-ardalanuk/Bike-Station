//
//  Route.swift
//  Data
//
//  Created by Amir Ardalan on 5/4/20.
//  Copyright © 2020 Clean-Coder. All rights reserved.
//

import Foundation

enum StationRoutes: String, RouteFactoryMethod {

    case stationList = "vrwc-rwgm.json"
    
    internal var baseUrl: String {
         get {
             return "https://data.melbourne.vic.gov.au/resource/"
         }
     }
    
    var route: RouteURL {
        return Route(endpoint: baseUrl + self.rawValue)
    }
    
}
