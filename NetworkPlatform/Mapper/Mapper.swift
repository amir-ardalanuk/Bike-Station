//
//  Mapper.swift
//  NetworkPlatform
//
//  Created by Amir Ardalan on 6/30/20.
//  Copyright © 2020 Clean-Coder. All rights reserved.
//

import Foundation
protocol Mapper {
    func map<T: Decodable>(data: Data) -> T?
}
