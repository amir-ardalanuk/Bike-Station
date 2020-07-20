//
//  StationMap_VM.swift
//  BikeApp
//
//  Created by Amir Ardalan on 18/07/2020.
//  Copyright © 2020 Clean-Coder. All rights reserved.
//

import Foundation
import Domain
import RxSwift
import RxCocoa

class StationMapViewModelDefault {
    
    let stationService: StationUsecase
    let navigation: StationMapNavigation
    let listOfStation = BehaviorSubject<[StationEntity]>(value: [])
    let bag = DisposeBag()
    
    init(stationService: StationUsecase,navigation: StationMapNavigation) {
        self.stationService = stationService
        self.navigation = navigation
    }
}

extension StationMapViewModelDefault: ViewModel {
    
    func transform(input: Input) -> Output {
        let activityInidcator = ActivityIndicator()
        let searchSelected = PublishSubject<StationEntity>()
        let services = input.getList.asObservable().flatMapLatest { _ in
            return self.stationService.getStationList().trackActivity(activityInidcator).do(onNext: { (list) in
                self.listOfStation.onNext(list)
            })
        }
        
        let markerStationClicked = input.markerClicked.map { id -> Int?  in
            guard let count = try? self.listOfStation.value().count, count > 0 else {
                return nil
            }
            return try? self.listOfStation.value().firstIndex { $0.stationId == id }
        }
        
        let searchSelectedIndex = searchSelected.map { searched -> Int? in
            return try! self.listOfStation.value().firstIndex { $0.stationId == searched.stationId }
        }.asDriverOnErrorJustComplete()
        
        let collcetionMove = Driver.merge(markerStationClicked,searchSelectedIndex)
        
        input.showSearchList.drive(onNext: { (_) in
            self.navigation.search(list: try! self.listOfStation.value()) { (itemSelected) in
                searchSelected.onNext(itemSelected)
            }
        }).disposed(by: bag)
        
        let collectionScrolled = input.scrolledOn.map { (index) -> (Double, Double)? in
            guard let count = try? self.listOfStation.value().count , count > 0, let indexStrong = index?.row else {
                return nil
            }
            let item = try? self.listOfStation.value()[indexStrong]
            return (item?.geocodedColumn?.latitude ?? Double.zero, item?.geocodedColumn?.longitude ?? Double.zero)
        }
        
        
        let searchSelectedLocation = searchSelected.map { item -> (Double, Double)? in
            return (item.geocodedColumn?.latitude ?? Double.zero, item.geocodedColumn?.longitude ?? Double.zero)
        }.asDriverOnErrorJustComplete()
        
        let moveMapCameraPosition = Driver.merge(collectionScrolled,searchSelectedLocation)
        let marker = services.asDriverOnErrorJustComplete()
        
        let stationList = services.map { (list) in
            return list.map {
                StationCollectionModel(name: $0.name, rental_method: $0.rentalMethod, capacity: $0.capacity)
            }
        }.asDriverOnErrorJustComplete()
        
        return Output(stationList: stationList, markerList: marker, loading: activityInidcator.asDriver(), moveCameraOn: moveMapCameraPosition, moveCollcetionIndex: collcetionMove)
    }
    
    struct Input {
        let getList: Driver<Void>
        let scrolledOn: Driver<IndexPath?>
        let markerClicked: Driver<String>
        let showSearchList: Driver<Void>
    }
    
    struct Output {
        let stationList: Driver<[StationCollectionModel]>
        let markerList: Driver<[StationEntity]>
        let loading: Driver<Bool>
        let moveCameraOn: Driver<(Double,Double)?>
        let moveCollcetionIndex: Driver<Int?>
    }
    
}
