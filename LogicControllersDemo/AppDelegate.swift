//
//  AppDelegate.swift
//  LogicControllersDemo
//
//  Created by Mike Gopsill on 14/09/2018.
//  Copyright © 2018 Mike Gopsill. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let logicController = ProfileLogicController()
        let viewController = ProfileViewController(with: logicController)
        viewController.view.backgroundColor = UIColor.cyan
        
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
        
        return true
    }
}

