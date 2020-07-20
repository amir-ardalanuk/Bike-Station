//
//  StationMap_VC.swift
//  BikeApp
//
//  Created by Amir Ardalan on 18/07/2020.
//  Copyright © 2020 Clean-Coder. All rights reserved.
//

import UIKit
import SwinjectStoryboard
import GoogleMaps
import Domain
import RxSwift
import RxCocoa

class StationMapVC: UIViewController {
    
    
    var viewModel: StationMapViewModelDefault!
    let getStationList = PublishSubject<Void>()
    let markerClicked = PublishSubject<String>()
    let bag = DisposeBag()
    var datasource = StationMapDataSource()
    var mapView: GMSMapView!
    
    @IBOutlet weak var btnSearch: UIBarButtonItem!
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            self.collectionView.register(StationCollcetionCell.self)
            self.datasource.collcetion = self.collectionView
            self.collectionView.dataSource = self.datasource
            self.collectionView.delegate = self.datasource
        }
    }
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMapView()
        binding()
        self.title = "Bike App"
        self.getStationList.onNext(())
    }
    
    func setupMapView() {
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        mapView.delegate = self
        self.view.insertSubview(mapView, belowSubview: self.collectionView)
    }
}

//binding
extension StationMapVC {
    func binding(){
        
        let input = StationMapViewModelDefault.Input(getList: getStationList.asDriverOnErrorJustComplete(),
                                                     scrolledOn: datasource.scrolledOn.asDriverOnErrorJustComplete(),
                                                     markerClicked: markerClicked.asDriverOnErrorJustComplete(),
                                                     showSearchList: btnSearch.rx.tap.asDriver())
        let output = viewModel.transform(input: input)
        output.loading.drive(activityIndicator.rx.isAnimating).disposed(by: bag)
        output.stationList.drive(self.collectionView.rx.stationList).disposed(by: bag)
        output.moveCollcetionIndex.drive(self.collectionView.rx.moveTo).disposed(by: bag)
        
        output.markerList.do(onNext: { (list) in
            let firstLocation = list.first
            self.moveCamera(lat:  firstLocation?.geocodedColumn?.latitude ?? Double.zero,lon: firstLocation?.geocodedColumn?.longitude ?? Double.zero)
        }).drive(onNext: addMarkerBy(_:)) .disposed(by: bag)
        
        output.moveCameraOn.asSharedSequence().drive(onNext: { (entity) in
            guard let latOLong = entity else {return}
            self.moveCamera(lat: latOLong.0, lon: latOLong.1)
        }).disposed(by: bag)
        
    }
}

//Map Function
extension StationMapVC: GMSMapViewDelegate {
    
    func addMarkerBy(_ list: [StationEntity]){
        list.forEach { (station) in
            let marker = CirculeMarker(size:  Int(station.capacity ?? "5") ?? 5,
                                       id: station.stationId ?? "",
                                       labelString: station.capacity ?? "UN",
                                       lat: station.geocodedColumn?.latitude ?? Double.zero,
                                       lon: station.geocodedColumn?.longitude ?? Double.zero)
            marker.marker().map = self.mapView
        }
    }
    
    func moveCamera(lat:Double, lon: Double){
        let camera = GMSCameraUpdate.setCamera(GMSCameraPosition.init(latitude: lat,
                                                                      longitude: lon,
                                                                      zoom: 15) )
        self.mapView.moveCamera(camera)
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        guard let cMarker = marker.iconView as? CirculeMarker, let id = cMarker.getId() else {
            return true
        }
        self.markerClicked.onNext(id)
        return true
    }
}

