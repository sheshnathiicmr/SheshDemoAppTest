//
//  UIImageView.swift
//  RideCell
//
//  Created by ityx  on 03/07/22.
//

import Foundation
import UIKit

extension UIImageView {

    func displayImage(with url:String) {
        let url = URL(string: url)
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url!) {
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            }
        }
    }
}
