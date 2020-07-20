//
//  BaseNetwork.swift
//  AANetwork
//
//  Created by Amir Ardalan on 4/24/20.
//  Copyright © 2020 Clean-Coder. All rights reserved.
//

import Foundation

public protocol BaseNetwork {
    func load(url: String, method: BaseNetworkMethod, payload: Any?, decoder: BaseNetworkDecoder, complete: @escaping (BaseNetworkCallBack) -> Void)
    func cancel()
    
    func isConnectedToIntenet() -> Bool
}
