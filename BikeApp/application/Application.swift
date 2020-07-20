//
//  Application.swift
//  UI in Code
//
//  Created by Amir Ardalan on 7/1/20.
//  Copyright © 2020 Clean-Coder. All rights reserved.
//

import UIKit
import SwinjectStoryboard


class Application {
    let mainAssembler = MainAssembler()
    var window: UIWindow?
    
    init() {
        
    }
    
    
    func setupWindow() {
        let window  = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        
        let storyboard = SwinjectStoryboard.create(name: "Main", bundle: nil)
        
        window.backgroundColor = .black
        window.rootViewController = storyboard.instantiateInitialViewController()
        
        self.window = window
        
    }
}
