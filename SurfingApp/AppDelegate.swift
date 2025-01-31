//
//  AppDelegate.swift
//  SurfingApp
//
//  Created by Dilara ACISU on 30.01.2025.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    static let apiKey = "15086ca2e29f450696f43c6bc4bebf1e"
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let bounds = UIScreen.main.bounds
        self.window = UIWindow(frame: bounds)
        self.window?.makeKeyAndVisible()
        
        let splashViewController = SplashViewController()
        let navigationController = UINavigationController(rootViewController: splashViewController)
        window?.rootViewController = navigationController
    
        return true
    }
}
