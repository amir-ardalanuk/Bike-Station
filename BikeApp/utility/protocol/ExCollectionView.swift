//
//  UICollectionView.swift
//  OKala
//
//  Created by Amir Ardi on 12/10/17.
//  Copyright © 2017 Mo. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionView {

    func dequeueReusableCell<T: UICollectionViewCell>(indexPath: IndexPath) -> T where T: ReusableView {
        print(T.reuseIdentifier)
        let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as! T
        return cell
    }

    func reloadData(completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0, animations: {
            self.reloadData()
        }, completion: {_ in
            completion()
        })
    }
}

extension UICollectionView {

    func register<T: UICollectionViewCell>(_ type: T.Type) where T: NibLoadable, T: ReusableView {
        let nib = UINib(nibName: T.nibName, bundle: nil)
        self.register(nib, forCellWithReuseIdentifier: T.reuseIdentifier)
    }
}
