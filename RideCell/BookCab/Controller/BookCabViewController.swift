//
//  BookCabViewController.swift
//  RideCell
//
//  Created by ityx  on 26/05/22.
//

import UIKit

class BookCabViewController: UIViewController {

    var viewModel:BookCabViewModel!
    
    ///MARK:- ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = BookCabViewModel()
        self.viewModel.getCabs { result in
            switch result {
            case let .success(cabs):
                print("total cabs: \(cabs.count)")
            case .failure(let error) :
                print("error: \(error.getErrorMessage())")
            }
        }
    }


}

