//
//  ImageCache.swift
//  SixT
//
//  Created by ityx  on 03/07/22.
//

import Foundation
import UIKit

class ImageCache {
    
    let cache = NSCache<NSString, UIImage>()
    
    static let shared = ImageCache()
    
    func getImage(with key:String) -> UIImage? {
        return self.cache.object(forKey: key as NSString)
    }
    
    func setImage(with key:String, image:UIImage) {
        self.cache.setObject(image, forKey: key as NSString)
    }
    
}
