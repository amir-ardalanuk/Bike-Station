//
//  Connectable.swift
//  DatePickerModule
//
//  Created by Amir Ardalan on 4/14/20.
//  Copyright © 2020 Clean-Coder. All rights reserved.
//

import UIKit

protocol Connectable {}

extension Connectable where Self: UIView {
    func commit() {
        let nib = UINib(nibName: String(describing: Self.self), bundle: nil)
        let views = nib.instantiate(withOwner: self, options: nil)
        guard let view = views.first as? UIView else {return}
        view.frame = bounds
        view.accessibilityIdentifier = "\(String(describing: Self.self))"
        addSubview(view)
    }
}
