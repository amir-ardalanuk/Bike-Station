//
//  RouteFactory.swift
//  Data
//
//  Created by Amir Ardalan on 6/27/20.
//  Copyright © 2020 Clean-Coder. All rights reserved.
//

import Foundation

protocol RouteFactoryMethod {
    var route: RouteURL {get}
    var baseUrl: String {get}
}

protocol RouteURL {
    var endpoint: String {get}
}

extension RouteURL {
}

struct Route: RouteURL {

    var endpoint: String
}
