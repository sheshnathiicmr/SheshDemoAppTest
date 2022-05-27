//
//  CabPointAnnotation.swift
//  RideCell
//
//  Created by ityx  on 27/05/22.
//

import Foundation
import MapKit

class CabPointAnnotation: MKPointAnnotation {
    var cab:Cab
    
    init(cab:Cab) {
        self.cab = cab
    }
    
}
