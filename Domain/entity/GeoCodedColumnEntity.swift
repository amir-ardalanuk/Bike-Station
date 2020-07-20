//
//  GeoCodedColumnEntity.swift
//  Domain
//
//  Created by Amir Ardalan on 18/07/2020.
//  Copyright © 2020 Clean-Coder. All rights reserved.
//

import Foundation
public struct GeocodedColumnEntity : Codable {

    private let stringLatitude : String?
    private let stringLongitude : String?
    
   public var latitude: Double? {
        return Double(self.stringLatitude ?? "")
    }
    
    public var longitude: Double? {
        return Double(self.stringLongitude ?? "")
    }


    enum CodingKeys: String, CodingKey {
        case stringLatitude = "latitude"
        case stringLongitude = "longitude"
    }
  
}
