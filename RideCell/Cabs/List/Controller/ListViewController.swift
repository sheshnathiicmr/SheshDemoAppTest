//
//  ListViewController.swift
//  RideCell
//
//  Created by ityx  on 02/07/22.
//

import UIKit

class ListViewController: BaseLayoutViewController {

    ///MARK:- StaticMethods
    class func initWithStoryboard() -> ListViewController {
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        let listViewController = storyboard.instantiateViewController(withIdentifier: "ListViewController") as! ListViewController
        return listViewController
    }
    
    // MARK: - ViewLifeCycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func dataAvailable(cabs: [Cab]) {
        
    }
}
