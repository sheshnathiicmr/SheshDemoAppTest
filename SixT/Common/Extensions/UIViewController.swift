//
//  UIViewController.swift
//  SixT
//
//  Created by sheshnath  on 26/05/22.
//

import Foundation
import UIKit

extension UIViewController {
    
    func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }

    /// It removes the child view controller from the parent.
    func removeChildViewcontroller() {
        guard let _ = parent else {return }
        willMove(toParent: nil)
        removeFromParent()
        view.removeFromSuperview()
    }
    
    /// Present AlertController
    func presentAlert(withTitle title: String?, message : String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title:"OK", style: .default) { action in
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
}
