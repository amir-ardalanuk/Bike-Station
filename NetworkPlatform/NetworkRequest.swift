//
//  ٔNetwork.swift
//  AANetworkProvider
//
//  Created by Amir Ardalan on 3/31/20.
//  Copyright © 2020 Clean-Coder. All rights reserved.
//

import Foundation
import RxSwift
import Swinject

public class NetworkRequest {

    var networkCall: BaseNetwork
  
    init(call: BaseNetwork) {
        self.networkCall = call
    }
    
    public func makeRequest<ResponseType: Decodable>(provider: NetworkProvider, ofType: ResponseType.Type, compelet: @escaping (ResponseType?) -> Void, error: @escaping(Error) -> Void ) {
        fatalError("You should impliment this body on your own class")
    }
    
    public func makeRXRequest<ResponseType: Decodable>(provider: NetworkProvider, ofType: ResponseType.Type) -> Single<ResponseType> {
        fatalError("You should impliment this body on your own concreat class")
    }
    
    //func observableRequest<Response>(provider: NetworkProvider)-> Single<Response?>
    func errorHandeling<ResponseType>(_ status: Int, data: ResponseType?, ofType: ResponseType.Type) -> Error? {
        fatalError("You should impliment this body on your own concreat class")
    }
    
    public func hasConnection() -> Observable<Bool> {
        return Observable.just( self.networkCall.isConnectedToIntenet())
    }
    
}

extension NetworkRequest {
    
  internal func  request(provider: NetworkProvider, compelet: @escaping (BaseNetworkCallBack?) -> Void) {
    guard let method = BaseNetworkMethod(rawValue: provider.method.rawValue) else {
            compelet(.failure(BaseNetworkResult(status: nil, error: NetworkError.errorHTTPMethod, data: nil)))
            return
        }
        let decoder: BaseNetworkDecoder = BaseNetworkDecoder(rawValue: provider.encoding.rawValue) ?? .json
        
        networkCall.load(url: provider.endPoint,
                      method: method,
                      payload: provider.param,
                      decoder: decoder) { (response) in
                        compelet(response)
        }
    }
}
