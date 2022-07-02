//
//  MapViewModel.swift
//  RideCell
//
//  Created by ityx  on 02/07/22.
//

import UIKit
import MapKit

protocol CabSelectionChangeDelegate: AnyObject {
    func selectedCabChanged(cab:Cab, isInitialSelection:Bool)
}

class MapViewModel {

    private var dataSourceViewModel:DataSourceViewModel!
    
    init(dataSourceViewModel:DataSourceViewModel) {
        self.dataSourceViewModel = dataSourceViewModel
    }
    
    func setSelectedCab(cab:Cab)  {
        self.dataSourceViewModel.setSelectedCab(cab: cab)
    }
    
    func getSelectedCab() -> Cab? {
        return self.dataSourceViewModel.getSelectedCab()
    }
    
    func getRegion(for cab:Cab) -> MKCoordinateRegion? {
        guard let lat = cab.latitude, let lng = cab.longitude else { return nil}
        let location = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        let region = MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03))
        return region
    }
    
    func getAnnotation(for cab:Cab) -> CabPointAnnotation? {
        guard let lat = cab.latitude, let lng = cab.longitude else { return nil }
        let location = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        let cabAnnotation = CabPointAnnotation(cab: cab)
        cabAnnotation.coordinate = location
        cabAnnotation.title = cab.licensePlate
        cabAnnotation.subtitle = cab.name
        return cabAnnotation
    }
    
}
