//
//  CirculeMarker.swift
//  BikeApp
//
//  Created by Amir Ardalan on 18/07/2020.
//  Copyright © 2020 Clean-Coder. All rights reserved.
//

import UIKit
import GoogleMaps

class CirculeMarker: UIView {
    private var lat: Double?
    private var lon: Double?
    private var id: String?
    
    
    private let lable: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    convenience init(size: Int, id: String, labelString: String, lat: Double, lon: Double){
        self.init()
        
        self.id = id
        self.lat = lat
        self.lon = lon
        self.frame.size = CGSize(width: size * 2, height: size * 2)
        self.radius(self.frame.width / 2)
        self.lable.text = labelString
        
        self.addSubview(lable)
        let labelConstraint = [
            self.lable.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.lable.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ]
        NSLayoutConstraint.activate(labelConstraint)
        self.backgroundColor = .black
    }
}

extension CirculeMarker {
    func getId()->String? {
        return self.id
    }
    func marker() -> GMSMarker {
        let position = CLLocationCoordinate2D(latitude: self.lat ?? 0.0, longitude: self.lon ?? 0.0)
        let marker = GMSMarker(position: position)
        marker.title = self.lable.text
        marker.iconView = self
        marker.tracksViewChanges = true
        return marker
    }
}
