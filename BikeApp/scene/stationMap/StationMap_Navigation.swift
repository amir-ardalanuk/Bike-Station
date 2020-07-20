//
//  StationMap_Navigation.swift
//  BikeApp
//
//  Created by Amir Ardalan on 18/07/2020.
//  Copyright © 2020 Clean-Coder. All rights reserved.
//

import Foundation
import Swinject
import SwinjectStoryboard
import RemotePlatform
import Domain

protocol StationMapNavigation {
    func search(list: [StationEntity], callback: @escaping ((StationEntity) -> Void))
}

class StationsMapNavigationDefault: StationMapNavigation {

    let navigation: UINavigationController?
    let stationListNavigation: StationListNavigation
    init(navigation: UINavigationController?, stationListNavigation: StationListNavigation) {
        self.navigation = navigation
        self.stationListNavigation = stationListNavigation
    }
    
    func search(list: [StationEntity], callback: @escaping ((StationEntity) -> Void)) {
        stationListNavigation.showList(list: list, selected: callback)
    }
    
    
}
class StationMapAssembly : Assembly {
    func assemble(container: Container) {
        container.storyboardInitCompleted(StationMapVC.self) { (r, c) in

            let remoteFacotory = r.resolve(RemoteFactory.self)!
            let stationListNavigation = r.resolve(StationListNavigation.self, argument: c.navigationController )!
            let navigation =  StationsMapNavigationDefault(navigation: c.navigationController,
                                                           stationListNavigation: stationListNavigation)
            c.viewModel = StationMapViewModelDefault(stationService: remoteFacotory.stationUsecase(), navigation:navigation)
        }
    }
}
