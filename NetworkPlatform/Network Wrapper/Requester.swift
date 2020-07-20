//
//  Requester.swift
//  AANetwork
//
//  Created by Amir Ardalan on 4/24/20.
//  Copyright © 2020 Clean-Coder. All rights reserved.
//

import Foundation
import RxSwift
import Swinject

public class Requester: NetworkRequest {
    
    var mapper: Mapper!
    
    public init(network: BaseNetwork) {
        super.init(call: network)
        mapper = JsonMapper()
    }
    
    func setMapper(mapper: Mapper) {
        self.mapper = mapper
    }
    
    public override func makeRequest<ResponseType: Decodable>(provider: NetworkProvider, ofType: ResponseType.Type, compelet: @escaping (ResponseType?) -> Void, error: @escaping (Error) -> Void) {
        DispatchQueue.global().async {
            self.request(provider: provider) { (callback) in
//                let cllss = ResponseType.self
//                // *** to decode json data for debugginh
//                //let json = try? JSONSerialization.jsonObject(with: callback?.data as? Data ?? Data(), options: []) as? [String : Any]
//                // *** END
//                let data = try? JSONDecoder().decode(cllss, from: callback?.data as? Data ?? Data())
                let data: ResponseType? = self.mapper.map(data: callback?.data as? Data ?? Data() )
                
                if let existError = callback?.error {
                    error(existError)
                    return
                }
                
                guard let status = callback?.statusCode else {
                    error(NetworkError.serverError)
                    return
                }
                
                if let checkError = self.errorHandeling(status, data: data, ofType: ofType) {
                    switch checkError {
                    case let err as NetworkStatusError where err == .tokenExpired:
                        //TODO: add Authentication refresh token handler
                        break
                    default:
                        error(checkError)
                    }
                    
                    return
                }
                
                compelet(data)
            }
        }
        
    }
    
    public override func makeRXRequest<ResponseType: Decodable>(provider: NetworkProvider, ofType: ResponseType.Type) -> PrimitiveSequence<SingleTrait, ResponseType> {
        
        return Single.create { [weak self](observer) -> Disposable in
            
            self?.makeRequest(provider: provider, ofType: ofType, compelet: { (data: ResponseType?) in
                guard let safeData = data else {
                    observer(.error(NetworkError.notFound("response is null")))
                    return
                }
                observer(.success(safeData))
            }, error: { (error) in
                observer(.error(error))
            })
            return Disposables.create {
                self?.networkCall.cancel()
            }
        }
        
    }
    
    public override func errorHandeling<ResponseType>(_ status: Int, data: ResponseType?, ofType: ResponseType.Type) -> Error? {
        if let networkStatusError = NetworkStatusError(rawValue: status) {
            return networkStatusError
        }
        switch status {
        case 200...299:
            return nil
        case -1:
            return NetworkError.couldNotMapToClass
        case 401:
            return NetworkError.unAuthorizeUser
        case 404:
            return NetworkError.notFound(data)
        default:
            return NetworkError.customError(data)
        }
    }
    
}

public class RequesterAssembly: Assembly {
    public init() { }
    
    public func assemble(container: Container) {
        container.register(Requester.self) { (resolver) in
            let baseNetwork = resolver.resolve(BaseNetwork.self)
            return Requester(network: baseNetwork!)
        }.inObjectScope(.weak)
    }
}
