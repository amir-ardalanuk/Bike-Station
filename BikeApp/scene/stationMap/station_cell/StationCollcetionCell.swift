//
//  StationCollcetionCell.swift
//  BikeApp
//
//  Created by Amir Ardalan on 18/07/2020.
//  Copyright © 2020 Clean-Coder. All rights reserved.
//

import UIKit

struct StationCollectionModel {
    
    let name: String?
    let rental_method: String?
    let capacity: String?
}

class StationCollcetionCell: UICollectionViewCell, ReusableView, NibLoadable {

    @IBOutlet weak var lblCapacity: UILabel!
    @IBOutlet weak var lblRental: UILabel!
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var container: UIView! {
        didSet{
            self.container.radius(8)
        }
    }
}

//Lifecycle
extension StationCollcetionCell {
    override func awakeFromNib() {
           super.awakeFromNib()
           // Initialization code
       }
}

//binding
extension StationCollcetionCell {
    func config(dataModel : StationCollectionModel) {
        lblName.text = dataModel.name
        lblRental.text = dataModel.rental_method
        lblCapacity.text = dataModel.capacity
    }
}
