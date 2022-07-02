//
//  CabPin.swift
//  RideCell
//
//  Created by sheshnath  on 27/05/22.
//

import Foundation
import MapKit

class CabPin: MKAnnotationView {
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        self.canShowCallout = true
        self.image = UIImage(named: "CabPin")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
