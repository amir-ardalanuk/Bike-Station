//
//  Shadowable.swift
//  Retailer
//
//  Created by Amir Ardalan on 9/23/18.
//  Copyright © 2018 golrang. All rights reserved.
//

import Foundation
import UIKit
protocol Shadowable {
    
}

extension Shadowable where Self: UIView {
//    func dropShadow(_ color : UIColor = UIColor.black){
//        layer.shadowColor = color.cgColor
//        layer.shadowRadius = 4
//        layer.shadowOffset = CGSize(width: -1, height: -1)
//        self.layer.shadowOpacity = 0.2
//    }
    
    func dropShadow(_ color: UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2990689212)) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = 0.7
        // self.layer.shadowOffset = CGSize.zero
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.layer.shadowRadius = 6
        
        self.clipsToBounds = false
    }
    
    func dropShadow(shadowOpa: Float = 0.1, size: CGSize = CGSize(width: 1, height: 3) ) {
        self.layer.shadowColor = UIColor(red: 254/255, green: 30/255, blue: 154/255, alpha: 0.8).cgColor
        self.layer.shadowOffset = size
        self.layer.shadowOpacity = shadowOpa
        self.layer.masksToBounds = false
    }
    
}
