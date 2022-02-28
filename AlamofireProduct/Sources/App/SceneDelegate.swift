//
//  SceneDelegate.swift
//  AlamofireProduct
//
//  Created by Admin on 25.02.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

       func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
           
           guard let windowScene = (scene as? UIWindowScene) else { return }
           let window = UIWindow(windowScene: windowScene)
           
           let viewController = MainController()
           let navigationController = UINavigationController(rootViewController: viewController)
           
           window.rootViewController = navigationController
           self.window = window
           window.makeKeyAndVisible()
       }
}

