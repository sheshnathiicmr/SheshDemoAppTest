//
//  CabInfoViewController.swift
//  RideCell
//
//  Created by ityx  on 27/05/22.
//

import UIKit

class CabInfoViewController: UIViewController {

    ///MARK:- Outlets
    @IBOutlet weak var cabNumberPlateLabel: UILabel!
    
    
    ///MARK:- Proporties
    var cab:Cab!
    
    
    ///MARK:- StaticMethods
    class func initWithStoryboard(cab:Cab) -> CabInfoViewController {
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        let cabInfoViewController = storyboard.instantiateViewController(withIdentifier: "CabInfoViewController") as! CabInfoViewController
        cabInfoViewController.cab = cab
        return cabInfoViewController
    }
    
    ///MARK:- ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cabNumberPlateLabel.text = self.cab.licensePlateNumber
    }
    
}
