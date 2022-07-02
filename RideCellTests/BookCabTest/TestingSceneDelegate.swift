//
//  TestingSceneDelegate.swift
//  RideCellTests
//
//  Created by Sheshnath  on 28/05/22.
//

import UIKit
@testable import RideCell

class TestingSceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        if let mapViewController = self.window?.rootViewController as? MapViewController {
            print("map")
        }
        
        let mapViewController = MapViewController.initWithStoryboard()
        let viewModel = DataSourceViewModel(repository: MockRepository())
        mapViewController.viewModel = viewModel
        viewModel.delegate = mapViewController
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = mapViewController
        window?.makeKeyAndVisible()
    }
}
