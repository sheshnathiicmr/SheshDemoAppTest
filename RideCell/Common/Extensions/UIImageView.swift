//
//  UIImageView.swift
//  RideCell
//
//  Created by ityx  on 03/07/22.
//

import Foundation
import UIKit

extension UIImageView {

    func displayImage(with urlString:String) {
        if let cabImage = ImageCache.shared.getImage(with: urlString) {
            self.image = cabImage
            print("image from cache")
        }else {
            let url = URL(string: urlString)
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url!) {
                    if let cabImage = UIImage(data: data) {
                        ImageCache.shared.setImage(with: urlString, image: cabImage)
                        DispatchQueue.main.async {
                            self.image = cabImage
                            print("opps no cache")
                        }
                    }
                }
            }
        }
    }
}
