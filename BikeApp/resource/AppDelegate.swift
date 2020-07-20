//
//  AppDelegate.swift
//  BikeApp
//
//  Created by Amir Ardalan on 18/07/2020.
//  Copyright © 2020 Clean-Coder. All rights reserved.
//

import UIKit
import GoogleMaps

@UIApplicationMain
class AppDelegate: UIResponder {
    
    var app: Application!
    var googleApiKey = "AIzaSyDnDCK7RUQ46b7qSvNXEgs4DhtI123KBkc"
    
    override init() {
        super.init()
        GMSServices.provideAPIKey(googleApiKey)
        app = Application()
    }
}

extension AppDelegate: UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        app.setupWindow()
        return true
    }
}


