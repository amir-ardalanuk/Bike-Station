//
//  ReusableView.swift
//  OKala
//
//  Created by Amir Ardi on 12/10/17.
//  Copyright © 2017 Mo. All rights reserved.
//

import Foundation
import UIKit

protocol ReusableView {}

extension ReusableView where Self: UIView {

    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
extension ReusableView where Self: UIViewController {

    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    static func controller(storyname: String) -> UIViewController {

            UIStoryboard.init(name: storyname, bundle: nil).instantiateViewController(identifier: reuseIdentifier)
    }
}
