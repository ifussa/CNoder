//
//  AppDelegate.swift
//  CNoder
//
//  Created by Fussa on 2017/6/13.
//  Copyright © 2017年 fussa. All rights reserved.
//

import UIKit
import Kingfisher
import SwifterSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        let nav = BaseNavigationController(rootViewController: MainViewController())
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        return true
    }

}

