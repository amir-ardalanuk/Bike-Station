//
//  StationEntity.swift
//  Domain
//
//  Created by Amir Ardalan on 18/07/2020.
//  Copyright © 2020 Clean-Coder. All rights reserved.
//

import Foundation
public struct StationEntity: Codable {
    
   public let capacity: String?
   public let geocodedColumn: GeocodedColumnEntity?
   public let lat: String?
   public let lon: String?
   public let name: String?
   public let rentalMethod: String?
   public let stationId: String?
    
    enum CodingKeys: String, CodingKey {
        case capacity = "capacity"
        case geocodedColumn = "geocoded_column"
        case lat = "lat"
        case lon = "lon"
        case name = "name"
        case rentalMethod = "rental_method"
        case stationId = "station_id"
    }
}
