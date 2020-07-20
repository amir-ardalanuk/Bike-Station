//
//  ExView.swift
//  UI in Code
//
//  Created by Amir Ardalan on 6/23/20.
//  Copyright © 2020 Clean-Coder. All rights reserved.
//

import UIKit

extension UIView {
    func aspectRation(_ ratio: CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: self, attribute: .width, multiplier: ratio, constant: 0)
    }
    
    func radius(_ value: CGFloat) {
        self.layer.cornerRadius = value
    }
    
    func makeConstraint(parent: UIView, margin: CGFloat) -> [NSLayoutConstraint] {
        let constraint = [
            self.topAnchor.constraint(equalTo: parent.topAnchor, constant: margin),
            self.bottomAnchor.constraint(equalTo: parent.bottomAnchor, constant: -margin),
            self.leftAnchor.constraint(equalTo: parent.leftAnchor, constant: margin),
            self.rightAnchor.constraint(equalTo: parent.rightAnchor, constant: -margin)
        ]
        return constraint
    }
    
    func makeConstraintSafeArea(parent: UIView, margin: CGFloat) -> [NSLayoutConstraint] {
        let constraint = [
            self.topAnchor.constraint(equalTo: parent.safeAreaLayoutGuide.topAnchor, constant: margin),
            self.bottomAnchor.constraint(equalTo: parent.safeAreaLayoutGuide.bottomAnchor, constant: -margin),
            self.leftAnchor.constraint(equalTo: parent.safeAreaLayoutGuide.leftAnchor, constant: margin),
            self.rightAnchor.constraint(equalTo: parent.safeAreaLayoutGuide.rightAnchor, constant: -margin)
        ]
        return constraint
    }
    
    func activateFillConstraint(with parent: UIView, margin: CGFloat) {
        NSLayoutConstraint.activate(
            makeConstraint(parent: parent, margin: margin)
        )
    }
    
    func activateFillSafeAreaConstraint(with parent: UIView, margin: CGFloat) {
        NSLayoutConstraint.activate(
            makeConstraintSafeArea(parent: parent, margin: margin)
        )
    }
}
