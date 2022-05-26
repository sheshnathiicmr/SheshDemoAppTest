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
        self.mapView.delegate = self
    }
    
    ///MARK:- HelperMethods
    private func zoomToFirstCabLocation(cab:Cab) {
        guard let lat = cab.lat, let lng = cab.lng else { return }
        let location = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        let region = MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        self.mapView.setRegion(region, animated: true)
        
        // Drop a pin at user's Current Location
        let myAnnotation: MKPointAnnotation = MKPointAnnotation()
        myAnnotation.coordinate = location
        myAnnotation.title = cab.licensePlateNumber
        myAnnotation.subtitle = cab.vehicleMake
        mapView.addAnnotation(myAnnotation)
        
    }
}

extension BookCabViewController: BookCabViewModelDelegate {
    
    func stateChanged(newState: MapState) {
        self.overlayView.isHidden = newState.shouldHideOverlayView
        self.overlayMessageLabel.text = newState.overlayViewMessage
        switch newState {
        case .loading:
            break
        case .loaded(let cabs):
            if let firstCab = cabs.first {
                self.zoomToFirstCabLocation(cab: firstCab)
            }
        case .failed(let customError):
            self.presentAlert(withTitle: "Error", message: customError.getErrorMessage())
        }
    }
}

extension BookCabViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if !(annotation is MKPointAnnotation) {
            return nil
        }
        let annotationIdentifier = "AnnotationIdentifier"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier)
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            annotationView!.canShowCallout = true
        }
        else {
            annotationView!.annotation = annotation
        }
        let pinImage = UIImage(named: "CabPin")
        annotationView!.image = pinImage
       return annotationView
    }
}
