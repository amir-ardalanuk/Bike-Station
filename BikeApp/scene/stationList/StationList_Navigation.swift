//
//  StationList_VC.swift
//  BikeApp
//
//  Created by Amir Ardalan on 19/07/2020.
//  Copyright © 2020 Clean-Coder. All rights reserved.
//

import UIKit
import Domain
import Swinject

protocol StationListNavigation {
    func showList(list: [StationEntity], selected: @escaping (_ id: StationEntity) -> Void )
    func pop(_ model: StationEntity )
}

class StationListNavigationDefault: StationListNavigation {

    let navigation: UINavigationController?
    var callback: ((StationEntity) -> Void)?
    
    init(navigation: UINavigationController?) {
        self.navigation = navigation
    }
    
    func pop(_ model: StationEntity ){
        self.navigation?.viewControllers.last?.dismiss(animated: true, completion: { [weak self]  in
            self?.callback?(model)
        })
    }
    
    func showList(list: [StationEntity], selected: @escaping (StationEntity) -> Void) {
        self.callback = selected
        let vm = StationListVM(navigation: self, list: list)
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "StationListVC") as! StationListVC
        
        vc.viewModel = vm
        navigation?.present(vc, animated: true)
    }
    
}

class StationListNavigationAssembly: Assembly {
    func assemble(container: Container) {
        container.register(StationListNavigation.self) { (resolver, data)  in
            return StationListNavigationDefault(navigation: data)
        }
    }
    
    
}
