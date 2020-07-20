//
//  DeliveryDataSource.swift
//  UI in Code
//
//  Created by Amir Ardalan on 6/23/20.
//  Copyright © 2020 Clean-Coder. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Domain

class StationMapDataSource: NSObject, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    private var list: [StationCollectionModel] = [StationCollectionModel]()
    public var selectItem = BehaviorSubject<IndexPath?>(value: nil)
    public var scrolledOn = BehaviorSubject<IndexPath?>(value: nil)

    private let bag = DisposeBag()
    public var collcetion:UICollectionView!
    
    func update(_ list: [StationCollectionModel]) {
        self.list = list
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: StationCollcetionCell = collectionView.dequeueReusableCell(indexPath: indexPath)
        cell.config(dataModel: self.list[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        print(sourceIndexPath,destinationIndexPath)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let center = CGPoint(x: scrollView.contentOffset.x + (scrollView.frame.width / 2), y: (scrollView.frame.height / 2))
               let ip = self.collcetion.indexPathForItem(at: center)
            scrolledOn.onNext(ip)
    }
}

extension Reactive where Base: StationMapDataSource {
    internal var stationCollcetionList: Binder<[StationCollectionModel]> {
        return Binder(self.base, binding: { (view, data) in
            view.update(data)
        })
    }
    
}

extension Reactive where Base: UICollectionView {
    internal var stationList: Binder<[StationCollectionModel]> {
        return Binder(self.base, binding: { (view, data) in
            if let datasource = view.dataSource as? StationMapDataSource {
                datasource.update(data)
                DispatchQueue.main.async {
                    view.reloadData {
                        print("reload")
                    }
                }
            }
        })
    }
    
    internal var moveTo: Binder<Int?> {
        return Binder(self.base, binding: { (view, data) in
            guard let _index = data else {return}
            view.layoutIfNeeded()
            let indexPath = IndexPath(row: _index, section: 0)
            view.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        })
    }
}
