//
//  BaseViewController.swift
//  RideCell
//
//  Created by ityx  on 02/07/22.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addLayoutChangeNavigationButton()
    }
    
    private func addLayoutChangeNavigationButton() {
        let button = UIButton.init(type: .custom)
        button.setImage(UIImage(named: "ListView"), for: .normal)
        button.addTarget(self, action: #selector(layoutChangeTapped), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 53, height: 51)
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    @objc func layoutChangeTapped()  {
        self.performSegue(withIdentifier: "cabListSegue", sender: self)
    }
    
}
