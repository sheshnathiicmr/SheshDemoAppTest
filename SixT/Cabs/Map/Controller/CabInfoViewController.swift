//
//  CabInfoViewController.swift
//  SixT
//
//  Created by sheshnath  on 27/05/22.
//

import UIKit

class CabInfoViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var licensePlateNumberLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var fuelLevelLabel: UILabel!
    @IBOutlet weak var makeLabel: UILabel!
    @IBOutlet weak var name: UILabel!
    
    //MARK: - Proporties
    var cab:Cab!
    
    //MARK: - StaticMethods
    class func initWithStoryboard(cab:Cab) -> CabInfoViewController {
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        let cabInfoViewController = storyboard.instantiateViewController(withIdentifier: "CabInfoViewController") as! CabInfoViewController
        cabInfoViewController.cab = cab
        return cabInfoViewController
    }
    
    //MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindCabInfo()
    }
    
    //MARK: - HelperMethods
    private func bindCabInfo() {
        self.licensePlateNumberLabel.text = self.cab.licensePlate
        self.fuelLevelLabel.text = "\(self.cab.fuelLevel)"
        self.makeLabel.text = self.cab.make
        self.name.text = cab.name
        self.setBackgroundImage()
    }
    
    private func setBackgroundImage() {
        self.backgroundImageView.image = UIImage() //remove image initially to avoid using wrong position image
        self.backgroundImageView.displayImage(with: cab.carImageUrl)
    }
}
