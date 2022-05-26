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
        self.viewModel.getCabs()
    }


}

