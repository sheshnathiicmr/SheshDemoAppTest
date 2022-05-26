//
//  UIViewController.swift
//  RideCell
//
//  Created by ityx  on 26/05/22.
//

import Foundation
import UIKit

extension UIViewController {
    
    /// Present AlertController
    func presentAlert(withTitle title: String?, message : String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title:"OK", style: .default) { action in
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
}
