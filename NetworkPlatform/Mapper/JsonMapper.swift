//
//  JsonMapper.swift
//  NetworkPlatform
//
//  Created by Amir Ardalan on 6/30/20.
//  Copyright © 2020 Clean-Coder. All rights reserved.
//

import Foundation

struct JsonMapper: Mapper {
    func map<T>(data: Data) -> T? where T: Decodable {
        let cllss = T.self
        // *** to decode json data for debugginh
        //let json = try? JSONSerialization.jsonObject(with: callback?.data as? Data ?? Data(), options: []) as? [String : Any]
        // *** END
        let model = try? JSONDecoder().decode(cllss, from: data)
        return model
    }   
}
