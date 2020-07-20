//
//  NetworkStatusError.swift
//  AANetwork
//
//  Created by Amir Ardalan on 5/5/20.
//  Copyright © 2020 Clean-Coder. All rights reserved.
//

import Foundation
enum NetworkStatusError: Int, Error {
    case badRequest                                = 400
    case notAuthorizedToAccessThisService      = 401
    case methodNotSupported                       = 405
    case tokenExpired                              = 420
    case tokenAlreadyExist                        = 421
    case serverError                               = 500
    case invalidCredentialsSupplied               = 600
    case userExpired                               = 601
    case dataOverused                              = 602
    case maximumLimitationPerUser                = 603
    case pinDepleted                               = 604
    case alreadyLogin                              = 605
    case userIsNotLoggedIn                      = 606
    case pinIsDisabled                            = 607
}
