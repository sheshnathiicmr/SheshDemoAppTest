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
}

class MainViewController: UIViewController {

    //MARK: Properties
    var mapViewController:MapViewController?
    var listViewController:ListViewController?
    var layoutType:LayoutType = .list
    
    //MARK: ViewLifeCycle methos
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addLayoutChangeNavigationButton()
        self.displayNextLayout()
    }
    
    //MARK: helper methos
    private func showMapView() {
        let mapVC = MapViewController.initWithStoryboard()
        self.mapViewController = mapVC
        let viewModel = MapViewModel(repository: CabRepository())
        mapVC.viewModel = viewModel
        viewModel.delegate = mapVC
        self.add(mapVC)
    }
    
    private func showListView() {
        let listVC = ListViewController.initWithStoryboard()
        self.listViewController = listVC
        self.add(listVC)
    }
    
    private func addLayoutChangeNavigationButton() {
        let button = UIButton.init(type: .custom)
        button.setImage(UIImage(named: "ListView"), for: .normal)
        button.addTarget(self, action: #selector(displayNextLayout), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 53, height: 51)
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    //MARK: Actions
    @objc func displayNextLayout()  {
        self.layoutType = self.layoutType.nextLayout
        switch self.layoutType {
        case .list:
            self.showListView()
        case .map:
            self.showMapView()
        }
    }
    
}
