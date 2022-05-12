//
//  AppDelegate.swift
//  SearchingUserGithub
//
//  Created by CoffeeLatte on 12/05/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        createWindow()
        setDefaultRootViewController()
        
        return true
    }
    
    private func createWindow() {
        let windowFrame = UIScreen.main.bounds
        self.window = UIWindow(frame: windowFrame)
        self.window?.makeKeyAndVisible()
    }
    
    func setDefaultRootViewController() {
        let mainCoordiator = MainScreenCoordinator(window: window)
        mainCoordiator.start()
    }
}

