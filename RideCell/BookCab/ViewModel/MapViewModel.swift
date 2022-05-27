//
//  MapViewModel.swift
//  RideCell
//
//  Created by ityx  on 26/05/22.
//

import Foundation

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
    private var delegate:MapViewModelDelegate!
    private var repository:CabRepositoryProtocol!
    
    private var state:MapState = .loading {
        didSet{
            self.delegate.stateChanged(newState: self.state)
        }
    }

    private var selectedCab:Cab!
    
    ///MARK:- Initialiser
    init(repository:CabRepositoryProtocol, delegate:MapViewModelDelegate) {
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
        }
    }
    
    func setSelectedCab(cab:Cab)  {
        self.selectedCab = cab
    }
    
    func getSelectedCab() -> Cab {
        return self.selectedCab
    }
}
