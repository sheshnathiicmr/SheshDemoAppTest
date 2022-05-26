//
//  BookCabViewController.swift
//  RideCell
//
//  Created by ityx  on 26/05/22.
//

import UIKit
import MapKit

class BookCabViewController: UIViewController {

    ///MARK:- Outlets
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var overlayMessageLabel: UILabel!
    @IBOutlet weak var overlayView: UIView!
    ///MARK:- Propterties
    var viewModel:BookCabViewModel!
    
    ///MARK:- ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = BookCabViewModel(repository: Repository(), delegate: self)
    }
}

extension BookCabViewController: BookCabViewModelDelegate {
    
    func stateChanged(newState: MapState) {
        self.overlayView.isHidden = newState.shouldHideOverlayView
        self.overlayMessageLabel.text = newState.overlayViewMessage
        
    }
}
