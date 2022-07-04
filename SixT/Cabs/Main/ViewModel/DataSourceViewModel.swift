//
//  DataSourceViewModel.swift
//  SixT
//
//  Created by sheshnath  on 26/05/22.
//

import Foundation


enum DataSourceState {
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

protocol DataSourceModelDelegate: AnyObject {
    func stateChanged(newState:DataSourceState)
}

class DataSourceViewModel {

    //MARK: - Proporties
    weak var delegate:DataSourceModelDelegate?
    var state:DataSourceState = .loading
    private var repository:CabRepositoryProtocol!
    private var selectedCab:Cab!
    
    init(repository:CabRepositoryProtocol) {
        self.repository = repository
    }
    
    //MARK: - Methods
    func fetchCabsData() {
        self.delegate?.stateChanged(newState: self.state) //set initial state
        self.repository.fetchCabs(apiRequest: ApiRequestHandler()) { result in
            switch result {
            case let .success(cabs):
                self.selectedCab = cabs.first
                self.state = .loaded(cabs)
            case .failure(let error) :
                self.state = .failed(error)
            }
            self.delegate?.stateChanged(newState: self.state)
        }
    }
    
    func setSelectedCab(cab:Cab)  {
        self.selectedCab = cab
    }
    
    func getSelectedCab() -> Cab? {
        return self.selectedCab
    }
    
    func getCabs() -> [Cab]? {
        switch self.state {
        case .loaded(let cabs):
            return cabs
        default:
            return nil
        }
    }
    
}
