//
//  BookCabViewController.swift
//  RideCell
//
//  Created by ityx  on 26/05/22.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    ///MARK:- Outlets
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var overlayMessageLabel: UILabel!
    @IBOutlet weak var overlayView: UIView!
    ///MARK:- Propterties
    var viewModel:MapViewModel!
    var cabInfoPageViewController:CabInfoPageViewController!
    
    ///MARK:- ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = MapViewModel(repository: CabRepository(), delegate: self)
        self.mapView.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cabInfoPageVC = segue.destination as? CabInfoPageViewController {
            self.cabInfoPageViewController = cabInfoPageVC
            self.cabInfoPageViewController?.cabInfoPagedelegate = self
        }
    }
    
    ///MARK:- HelperMethods
    private func zoomToFirstCabLocation(cab:Cab) {
        guard let lat = cab.lat, let lng = cab.lng else { return }
        let location = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        let region = MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03))
        self.mapView.setRegion(region, animated: true)
    }
    
    private func addCabAnnotationOnMap(cabs:[Cab]) {
        for cab in cabs {
            // Drop a pin at cab's Current Location
            guard let lat = cab.lat, let lng = cab.lng else { return }
            let location = CLLocationCoordinate2D(latitude: lat, longitude: lng)
            let cabAnnotation = CabPointAnnotation(cab: cab)
            cabAnnotation.coordinate = location
            cabAnnotation.title = cab.licensePlateNumber
            cabAnnotation.subtitle = cab.vehicleMake
            mapView.addAnnotation(cabAnnotation)
        }
    }
}

extension MapViewController: MapViewModelDelegate {
    
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
            self.addCabAnnotationOnMap(cabs: cabs)
        case .failed(let customError):
            self.presentAlert(withTitle: "Error", message: customError.getErrorMessage())
        }
    }
}

extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if !(annotation is MKPointAnnotation) {
            return nil
        }
        let annotationIdentifier = "AnnotationIdentifier"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier)
        if annotationView == nil {
            annotationView = CabPin(annotation: annotation, reuseIdentifier: annotationIdentifier)
        }
        else {
            annotationView!.annotation = annotation
        }
       return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let cabPinView = view as? CabPin {
            if let cabPointAnnotation = cabPinView.annotation as? CabPointAnnotation {
                print("cab id: \(cabPointAnnotation.cab.id)")
            }
        }
    }
}

extension MapViewController: CabSelectionChangeDelegate {
    
    func selectedCabChanged(cab: Cab) {
        
    }
}
