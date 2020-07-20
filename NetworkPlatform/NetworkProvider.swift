//
//  NetworkProvider.swift
//  AANetworkProvider
//
//  Created by Amir Ardalan on 3/28/20.
//  Copyright © 2020 Clean-Coder. All rights reserved.
//

import Foundation
import RxSwift

public enum EncodingType: String {
    case json    =  "Json"
    case url  =  "Param"
}

public protocol NetworkProvider: AnyObject {
    var endPoint: String { get set}
    var needAuthenticate: Bool? {get set}
    var method: BaseNetworkMethod {get set}
    var param: [ String: Any ]? {get set}
    var header: [ String: String ]? {get set}
    var encoding: EncodingType {get set}
}

//public protocol AuthenticationProvider : class {
//
//}

public class DefaultNetworkProvider: NetworkProvider {

    public var needAuthenticate: Bool?
    public var endPoint: String
    public var method: BaseNetworkMethod
    public var param: [ String: Any ]?
    public var encoding: EncodingType
    public var header: [ String: String ]?
    
    init(endPoint: String, method: BaseNetworkMethod, param: [String: Any]?, header: [String: String]? = nil, encoding: EncodingType = .url, authenctication: Bool? = nil) {
        self.endPoint = endPoint
        self.method = method
        self.param = param
        self.needAuthenticate = authenctication
        self.header = header
        self.encoding = encoding 
    }
    
    deinit {
        print("Deinit  NetworkDefualtProvider")
       }
}

extension DefaultNetworkProvider {
    public static func make(route: String) -> DefaultNetworkProvider {
        return DefaultNetworkProvider(endPoint: route, method: .get, param: nil)
    }
}
