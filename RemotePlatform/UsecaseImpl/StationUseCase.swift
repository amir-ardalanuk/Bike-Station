//
//  StationUseCase.swift
//  RemotePlatform
//
//  Created by Amir Ardalan on 18/07/2020.
//  Copyright © 2020 Clean-Coder. All rights reserved.
//

import Foundation
import Domain
import RxSwift
import NetworkPlatform

public class StationUseCaseImpl {
    let network: NetworkRequest
    
    public init(network: NetworkRequest) {
        self.network = network
    }
}

extension StationUseCaseImpl: StationUsecase {
    public func getStationList() -> Observable<[StationEntity]> {
        let provider = DefaultNetworkProvider.make(route: StationRoutes.stationList.route.endpoint)
        return network.makeRXRequest(provider: provider, ofType: [StationEntity].self).asObservable()
    }

}
