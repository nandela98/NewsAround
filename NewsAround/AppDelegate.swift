//
//  AppDelegate.swift
//  NewsAround
//
//  Created by Sanjeeva Reddy Nandela on 8/5/22.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        if let window = window {
            window.backgroundColor = UIColor.white
            let mainTableViewController = HomeViewController()
            window.rootViewController = UINavigationController(rootViewController: mainTableViewController)
            window.makeKeyAndVisible()
        }
        return true
    }
    

}

