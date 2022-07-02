//
//  BaseLayoutViewController.swift
//  RideCell
//
//  Created by ityx  on 02/07/22.
//

import UIKit

class BaseLayoutViewController: UIViewController {

    //MARK: - ViewLifeCycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //MARK: - State update in respective layout i.e map & list override
    func dataAvailable(cabs:[Cab]) {
    }
}
