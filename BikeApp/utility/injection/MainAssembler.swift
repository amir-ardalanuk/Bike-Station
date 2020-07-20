//
//  MainAssembler.swift
//  AANetworkProvider
//
//  Created by Amir Ardalan on 4/26/20.
//  Copyright © 2020 Clean-Coder. All rights reserved.
//

import Foundation
import Swinject
import SwinjectStoryboard
import NetworkPlatform
import RemotePlatform


class MainAssembler {
    
    var resolver: Resolver {
        return assembler.resolver
    }
    
    let assembler = Assembler(container: SwinjectStoryboard.defaultContainer)
    
    init() {
        //Netowrk
        assembler.apply(assembly: URLSessionNetwork())
        assembler.apply(assembly: RequesterAssembly())
    
        // Remote
        assembler.apply(assembly: RemoteFactoryAssembly())
        
        //Controller
        assembler.apply(assembly: StationMapAssembly())
        assembler.apply(assembly: StationListNavigationAssembly())
    
    }
}
