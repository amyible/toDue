//
//  AppDelegate.swift
//  Example
//
//  Created by Lasha Efremidze on 3/8/17.
//  Copyright © 2017 efremidze. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
//        // Override point for customization after application launch.
//        return true
//    }
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        let controllerId = "Login";
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let initViewController: UIViewController = storyboard.instantiateViewController(withIdentifier: controllerId) as UIViewController
        self.window?.rootViewController = initViewController
        
        return true
    }
}
