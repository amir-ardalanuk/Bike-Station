//
//  StationList_VC.swift
//  BikeApp
//
//  Created by Amir Ardalan on 19/07/2020.
//  Copyright © 2020 Clean-Coder. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Domain

class StationListVM: ViewModel {
    
    let navigation: StationListNavigation
    let list: Observable<[StationEntity]>
    let bag = DisposeBag()
    
    init(navigation: StationListNavigation, list: [StationEntity]) {
        self.navigation = navigation
        self.list = Observable.from(optional: list)
    }
    
    func transform(input: StationListVM.Input) -> StationListVM.Output {
        let listItem = input.filter.withLatestFrom(self.list.asDriverOnErrorJustComplete()) { search,stationList -> [StationEntity] in
            if search.isEmpty {
                return stationList
            }
            return stationList.filter { ($0.name ?? "" ).contains(search) }
        }
        
        input.selected.withLatestFrom(listItem) { indexPath, list in
            let itemSelected  = list[indexPath.row]
            return itemSelected
            }.drive(onNext: self.navigation.pop(_:)).disposed(by: bag)
        
        return StationListVM.Output(list: listItem)
    }
    
    
    
}

// Mark : Binding
extension StationListVM {
    struct Input {
        var selected: Driver<IndexPath>
        var filter: Driver<String>
    }
    
    struct Output {
        var list: Driver<[StationEntity]>
    }
    
}
