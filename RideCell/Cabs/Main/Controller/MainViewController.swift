//
//  BaseViewController.swift
//  RideCell
//
//  Created by ityx  on 02/07/22.
//

import UIKit

enum LayoutType {
    case map
    case list

    var nextLayout:Self {
        get {
            switch self {
            case .map:
                return .list
            case .list:
                return .map
            }
        }
    }
    
    var layoutButtonIcon:String {
        get {
            switch self {
            case .map:
                return "ListView" //next step(layout) icon
            case .list:
                return "MapView"
            }
        }
    }
}

class MainViewController: UIViewController {

    ///MARK:- Properties
    var mapViewController:MapViewController?
    var listViewController:ListViewController?
    var layoutType:LayoutType = .list
    var layoutTypeButton:UIButton?
    var dataSourceViewModel:DataSourceViewModel!
    
    ///MARK:- Outlets
    @IBOutlet weak var overlayMessageLabel: UILabel!
    @IBOutlet weak var overlayView: UIView!
    
    ///MARK:- ViewLifeCycle methos
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSourceViewModel = DataSourceViewModel(repository: CabRepository())
        self.dataSourceViewModel.delegate = self
        self.dataSourceViewModel.fetchCabsData()
        self.addLayoutChangeNavigationButton()
    }
    
    ///MARK:-  helper methos
    private func showMapView() {
        if let mapLayoutVC = self.mapViewController {
            self.add(mapLayoutVC)
        }else {
            let mapVC = MapViewController.initWithStoryboard()
            self.mapViewController = mapVC
            let viewModel = MapViewModel(dataSourceViewModel: self.dataSourceViewModel)
            mapVC.viewModel = viewModel
            self.add(mapVC)
        }
    }
    
    private func showListView() {
        if let listLayoutVC = self.listViewController {
            self.add(listLayoutVC)
        }else {
            let listVC = ListViewController.initWithStoryboard()
            self.listViewController = listVC
            self.add(listVC)
        }
    }
    
    private func addLayoutChangeNavigationButton() {
        let button = UIButton.init(type: .custom)
        self.layoutTypeButton = button
        button.addTarget(self, action: #selector(displayNextLayout), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 53, height: 51)
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    ///MARK:-  Actions
    @objc func displayNextLayout()  {
        self.children.first?.removeChildViewcontroller() //remove previously add childviewcontroller, if any
        self.layoutType = self.layoutType.nextLayout
        switch self.layoutType {
        case .list:
            self.showListView()
        case .map:
            self.showMapView()
        }
        self.layoutTypeButton?.setImage(UIImage(named: self.layoutType.layoutButtonIcon), for: .normal)
    }
    
}

///MARK:- ViewModelDelegate
extension MainViewController: DataSourceModelDelegate {
    
    func stateChanged(newState: DataSourceState) {
        self.overlayView.isHidden = newState.shouldHideOverlayView
        self.overlayMessageLabel.text = newState.overlayViewMessage
        switch newState {
        case .loading:
            break
        case .loaded(let cabs):
            self.displayNextLayout()
            if let baseLayout = self.children.first as? BaseLayoutViewController {
                baseLayout.dataAvailable(cabs: cabs)
            }
        case .failed(let customError):
            self.presentAlert(withTitle: "Error", message: customError.getErrorMessage())
        }
    }
}

