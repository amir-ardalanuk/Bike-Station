//
//  NetworkError.swift
//  AANetworkProvider
//
//  Created by Amir Ardalan on 3/29/20.
//  Copyright © 2020 Clean-Coder. All rights reserved.
//

import Foundation
public enum NetworkError: Error {
    case errorMethodParameter
    case errorHTTPMethod
    case customError(Any?)
    case tokenExpired
    case unAuthorizeUser
    case couldNotMapToClass
    case notFound(Any?)
    case serverError
}
