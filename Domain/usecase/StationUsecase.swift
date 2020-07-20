//
//  GeneralAuthorization.swift
//  Data
//
//  Created by Amir Ardalan on 4/19/20.
//  Copyright © 2020 Clean-Coder. All rights reserved.
//

import Foundation
import RxSwift

public protocol StationUsecase {
    func getStationList()->Observable<[StationEntity]>
}
