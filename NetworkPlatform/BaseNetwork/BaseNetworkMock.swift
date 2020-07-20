//
//  AANetworkMockImp.swift
//  AANetworkTests
//
//  Created by Amir Ardalan on 4/24/20.
//  Copyright © 2020 Clean-Coder. All rights reserved.
//

import Foundation
import Swinject

public class BaseNetworkMock: BaseNetwork {
    
    public init() {}
    
    func setResult(result: BaseNetworkCallBack) {
       
    }
    public func isConnectedToIntenet() -> Bool {
          return true
      }
      
      var cancelRequest = false

    public func load(url: String, method: BaseNetworkMethod, payload: Any?, decoder: BaseNetworkDecoder, complete: @escaping (BaseNetworkCallBack) -> Void) {
        guard !url.isEmpty else {
            print( NetworkError.couldNotMapToClass)
            fatalError("SET RESULT Before Call load function")
        }
        
        var result: BaseNetworkCallBack?
        if let url = Bundle.main.url(forResource: url, withExtension: "json"), let data = try? Data(contentsOf: url) {
            result = BaseNetworkCallBack.success(BaseNetworkResult(status: 200, error: nil, data: data))
        } else {
            result = BaseNetworkCallBack.failure(BaseNetworkResult(status: 404, error: NetworkError.notFound(nil), data: nil))
        }
        complete(result!)
        
    }
    
    public func cancel() {
        self.cancelRequest = true
    }
}

extension BaseNetworkMock: Assembly {
    public func assemble(container: Container) {
        container.register(BaseNetwork.self) { _ in
            let baseNetwork = BaseNetworkMock()
            return baseNetwork
        }.inObjectScope(.weak)
    }

}
