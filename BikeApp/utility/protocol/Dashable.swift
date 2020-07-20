//
//  Dashable.swift
//  Retailer
//
//  Created by Amir Ardalan on 9/23/18.
//  Copyright © 2018 golrang. All rights reserved.
//

import Foundation
import UIKit
protocol Dashable {
    var dashLayer: CAShapeLayer? {get set}
   mutating func setDash(color: UIColor)
}

extension Dashable where Self: UIView {
    
    mutating func setDash(color: UIColor) {
        let shapeLayer = CAShapeLayer()
        let path = UIBezierPath(rect: self.bounds)
        
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = 3
        shapeLayer.lineDashPattern = [20, 5]
        dashLayer = shapeLayer
    }

    func setDashAnimating() {
            let basicAnim = CABasicAnimation(keyPath: "lineDashPhase")
            basicAnim.fromValue = 0
            basicAnim.toValue = self.dashLayer?.lineDashPattern?.reduce(0, { $0 + $1.intValue})
            basicAnim.duration = 1
            basicAnim.repeatCount = .infinity
            self.dashLayer?.add(basicAnim, forKey: "dash")
    }

}
