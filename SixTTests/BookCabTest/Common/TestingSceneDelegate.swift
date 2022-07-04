//
//  TestingSceneDelegate.swift
//  SixTTests
//
//  Created by Sheshnath  on 28/05/22.
//

import UIKit
@testable import SixT

class TestingSceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard (scene is UIWindowScene) else { return }
        
    }
}
