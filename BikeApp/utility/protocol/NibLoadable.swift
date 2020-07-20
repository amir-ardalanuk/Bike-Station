//
//  NibLoadable.swift
//  OKala
//
//  Created by Amir Ardi on 12/10/17.
//  Copyright © 2017 Mo. All rights reserved.
//

import Foundation
import UIKit

protocol NibLoadable {}

extension NibLoadable where Self: UIView {

    static var nibName: String {
        return String(describing: self)
    }
}
