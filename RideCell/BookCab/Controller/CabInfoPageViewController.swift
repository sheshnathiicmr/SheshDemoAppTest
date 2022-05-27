//
//  CabInfoPageViewController.swift
//  RideCell
//
//  Created by ityx  on 27/05/22.
//

import UIKit

class CabInfoPageViewController: UIPageViewController {

    ///MARK:- Propterties
    var selectedCab:Cab?
    var cabInfoPagedelegate:CabSelectionChangeDelegate?
    
    ///MARK:- ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
