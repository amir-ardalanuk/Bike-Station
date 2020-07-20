//
//  XMLMapper.swift
//  NetworkPlatform
//
//  Created by Amir Ardalan on 6/30/20.
//  Copyright © 2020 Clean-Coder. All rights reserved.
//

import Foundation
import XMLParsing

struct XMLMapper: Mapper {
    func map<T>(data: Data) -> T? where T: Decodable {
        let cllss = T.self
        let decode = try? XMLDecoder().decode(cllss, from: data)
        return decode
    }
}
