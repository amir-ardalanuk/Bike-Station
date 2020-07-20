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

class StationListVC: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        }
    }
    
    let bag = DisposeBag()
    var viewModel: StationListVM!
}

//Lifecycle
extension StationListVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.binding()
    }
}

// Mark : Binding
extension StationListVC {
    func binding(){
        let input = StationListVM.Input(selected: tableView.rx.itemSelected.asDriver(),
                                        filter: searchBar.rx.text.map { $0 ?? "" }.startWith("").asDriverOnErrorJustComplete())
        let output = viewModel.transform(input: input)
        output.list.drive(self.tableView.rx.items(cellIdentifier: "cell")) { row, model, cell in
           cell.textLabel?.text = "\(model.name ?? "-" )"
        }.disposed(by: bag)
    }
}

