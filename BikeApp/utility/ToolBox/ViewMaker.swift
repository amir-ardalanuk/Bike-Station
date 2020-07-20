//
//  ViewMaker.swift
//  UI in Code
//
//  Created by Amir Ardalan on 6/23/20.
//  Copyright © 2020 Clean-Coder. All rights reserved.
//

import UIKit
struct ViewMaker {
    static func makeStackView(axios: NSLayoutConstraint.Axis = .vertical, distribution: UIStackView.Distribution = .fill, aligment: UIStackView.Alignment = .fill, space: CGFloat = 0) -> UIStackView {
        let sv = UIStackView()
        sv.axis  = axios
        sv.alignment = aligment
        sv.distribution = UIStackView.Distribution.fill
        sv.spacing = space
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }
}
