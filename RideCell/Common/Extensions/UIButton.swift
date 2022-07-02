//
//  UIButton.swift
//  RideCell
//
//  Created by ityx  on 02/07/22.
//

import Foundation
import UIKit

extension UIButton {
    
    func makeRoundedButton() {
        self.layer.masksToBounds = false
        self.layer.cornerRadius = self.frame.width / 2
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius).cgPath
        self.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 1.0
    }
    
}
