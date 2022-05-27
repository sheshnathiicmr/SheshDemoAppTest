//
//  MapViewModel.swift
//  RideCell
//
//  Created by ityx  on 26/05/22.
//

import Foundation
import MapKit

enum MapState {
    case loading
    case loaded([Cab])
    case failed(CustomError)
    
    var shouldHideOverlayView:Bool {
        get {
            switch self {
            case .loading:
                return false
            case .loaded(_):
                return true
            case .failed(_):
                return false
            }
        }
    }
    
    var overlayViewMessage:String? {
        get {
            switch self {
            case .loading:
                return "please_wait".localized
            case .loaded(_):
                return nil
            case .failed(let error):
                return error.getErrorMessage()
            }
        }
    }
    
}

protocol MapViewModelDelegate {
    func stateChanged(newState:MapState)
}

protocol CabSelectionChangeDelegate {
    func selectedCabChanged(cab:Cab)
}


class MapViewModel {

    ///MARK:- Proporties
    var delegate:MapViewModelDelegate!
    private var repository:CabRepositoryProtocol!
    
    private var state:MapState = .loading

    private var selectedCab:Cab!
    
    ///MARK:- Initialiser
    func initialize(repository:CabRepositoryProtocol, delegate:MapViewModelDelegate) {
        self.delegate = delegate
        self.delegate.stateChanged(newState: self.state) //set initial state
        self.repository = repository
        self.repository.fetchCabs { result in
            switch result {
            case let .success(cabs):
                self.selectedCab = cabs.first
                self.state = .loaded(cabs)
            case .failure(let error) :
                self.state = .failed(error)
            }
            self.delegate.stateChanged(newState: self.state)
        }
    }
    
    func setSelectedCab(cab:Cab)  {
        self.selectedCab = cab
    }
    
    func getSelectedCab() -> Cab? {
        
        return self.selectedCab
    }
    
    func getRegion(for cab:Cab) -> MKCoordinateRegion? {
        guard let lat = cab.lat, let lng = cab.lng else { return nil}
        let location = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        let region = MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03))
        return region
    }
    
    func getAnnotation(for cab:Cab) -> CabPointAnnotation? {
        guard let lat = cab.lat, let lng = cab.lng else { return nil }
        let location = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        let cabAnnotation = CabPointAnnotation(cab: cab)
        cabAnnotation.coordinate = location
        cabAnnotation.title = cab.licensePlateNumber
        cabAnnotation.subtitle = cab.vehicleMake
        return cabAnnotation
    }
}
