//
//  AppDelegate.swift
//  AlamofireProduct
//
//  Created by Admin on 25.02.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let viewController = MainController(nibName: nil, bundle: nil)
        let navigationController = UINavigationController(rootViewController: viewController)
        
        self.window = UIWindow()
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
        
        return true
    }
}

