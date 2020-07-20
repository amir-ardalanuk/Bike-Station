//
//  NetworkCall.swift
//  AANetwork
//
//  Created by Amir Ardalan on 4/20/20.
//  Copyright © 2020 Clean-Coder. All rights reserved.
//

import Foundation
import Swinject

open  class URLSessionNetwork: BaseNetwork {
   
    var task: URLSessionTask?
    //let reachability : Reachability

    public init() {
      //  reachability = try!  Reachability()
    }
    
    deinit {
        print("Deinit  INetworkDefault")
    }
    
    public func cancel() {
        self.task?.cancel()
    }
    
    public func load(url: String, method: BaseNetworkMethod, payload: Any?, decoder: BaseNetworkDecoder, complete: @escaping (BaseNetworkCallBack) -> Void) {
        
        var component = URLComponents(string: url)
        var header = [ String: String ]()
        
        var param: Data?
        
        switch decoder {
        case .json:
            param = try? jsonDecoder(json: payload)
            header["Content-Type"] = "application/json"
            
        default:
            component?.queryItems = (payload as? [ String: Any ])?.queryItem
        }
        
        guard let url = component?.url else {return}
        
        var request = URLRequest(url: url)
        
        request.httpBody = param
        request.allHTTPHeaderFields = header
        request.httpMethod = method.rawValue
      
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            let statusCode = (response as? HTTPURLResponse)?.statusCode
            let result = BaseNetworkResult(status: statusCode, error: error, data: data)
            if error != nil {
                complete(.failure(result))
            } else {
                complete(.success(result))
            }
        }
        task.resume()
    }
   
    func jsonDecoder(json: Any?) throws -> Data? {
        guard let stJson = json else {
            return nil
        }
       do {
        return try JSONSerialization.data(withJSONObject: stJson, options: []) as Data
        } catch {
        throw NetworkError.couldNotMapToClass
        }
    }
    
    public func isConnectedToIntenet() -> Bool {
//        switch reachability.connection {
//        case .cellular,.wifi:
//            return true
//        case .unavailable,.none:
//            return  false
//        }
        return true
    }
}
extension Dictionary {
    var queryString: String {
        var output: String = ""
        forEach({ output += "\($0.key)=\($0.value)&" })
        output = String(output.dropLast())
        return output
    }
    var queryItem: [ URLQueryItem ] {
        var queryItems = [URLQueryItem]()
        for (key, value) in self {
            queryItems.append(URLQueryItem(name: key as? String ?? "", value: value as? String ?? ""))
        }
        return queryItems
    }
}
extension URLSessionNetwork: Assembly {
    public func assemble(container: Container) {
        container.register(BaseNetwork.self) { _ in
        let baseNetwork = URLSessionNetwork()
        return baseNetwork
        }.inObjectScope(.weak)
    }
}
