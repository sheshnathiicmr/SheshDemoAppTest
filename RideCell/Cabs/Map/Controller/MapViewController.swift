//
//  BookCabViewController.swift
//  RideCell
//
//  Created by sheshnath  on 26/05/22.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    ///MARK:- Outlets
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var reserveCarButton: UIButton!
    @IBOutlet weak var overlayMessageLabel: UILabel!
    @IBOutlet weak var overlayView: UIView!
    
    ///MARK:- Propterties
    var viewModel:DataSourceViewModel!
    var cabInfoPageViewController:CabInfoPageViewController!
    
    ///MARK:- StaticMethods
    class func initWithStoryboard() -> MapViewController {
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        let mapViewController = storyboard.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        return mapViewController
    }
    
    ///MARK:- ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.fetchCabsData()
        self.mapView.delegate = self
        self.setAppearance()
    }
    
    ///MARK:- Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cabInfoPageVC = segue.destination as? CabInfoPageViewController {
            self.cabInfoPageViewController = cabInfoPageVC
            self.cabInfoPageViewController?.cabInfoPageDelegate = self
        }
    }
    
    ///MARK:- HelperMethods
    private func setAppearance() {
        self.reserveCarButton.layer.cornerRadius = 4.0
    }
    
    private func zoomToCabLocation(cab:Cab) {
        guard let region = self.viewModel.getRegion(for: cab) else { return }
        self.mapView.setRegion(region, animated: true)
    }
    
    private func addCabAnnotationOnMap(cabs:[Cab]) {
        for cab in cabs {
            // Drop a pin at cab's Current Location
            if let cabAnnotation = self.viewModel.getAnnotation(for: cab) {
                mapView.addAnnotation(cabAnnotation)
            }
        }
    }
    
}

///MARK:- ViewModelDelegate
extension MapViewController: DataSourceViewModelDelegate {
    
    func stateChanged(newState: DataSourceState) {
        self.overlayView.isHidden = newState.shouldHideOverlayView
        self.overlayMessageLabel.text = newState.overlayViewMessage
        switch newState {
        case .loading:
            break
        case .loaded(let cabs):
            if let cab = self.viewModel.getSelectedCab() {
                self.addCabAnnotationOnMap(cabs: cabs)
                self.cabInfoPageViewController.cabs = cabs
                self.cabInfoPageViewController.selectedCabChanged(cab: cab)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
                    guard let self = self else { return }
                    self.selectedCabChanged(cab: cab, isInitialSelection: true)
                }
            }
        case .failed(let customError):
            self.presentAlert(withTitle: "Error", message: customError.getErrorMessage())
        }
    }
}

///MARK:- MKMapViewDelegate
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
                self.viewModel.setSelectedCab(cab: cabPointAnnotation.cab)
                self.cabInfoPageViewController.selectedCabChanged(cab: cabPointAnnotation.cab)
            }
        }
    }
}

///MARK:- selection change from page swipe
extension MapViewController: CabSelectionChangeDelegate {
    
    func selectedCabChanged(cab: Cab, isInitialSelection:Bool) {
        if cab == self.viewModel.getSelectedCab()  && isInitialSelection == false {
            return
        }
        self.viewModel.setSelectedCab(cab: cab)
        self.zoomToCabLocation(cab: cab)
        let annotations = mapView.annotations.filter { annotation in
            guard let cabPointAnnotation = annotation as? CabPointAnnotation else { return false}
            return cabPointAnnotation.cab == cab
        }
        if let annotation = annotations.first as? CabPointAnnotation {
            self.mapView.selectAnnotation(annotation, animated: true)
        }
    }
}
