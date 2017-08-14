//
//  AppDelegate.swift
//  testSber
//
//  Created by Aidar on 13.08.17.
//  Copyright © 2017 Aidar Khakimzyanov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    private let appDependencies = AppDependencies()


//MARK: - Application Methods
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        return appDependencies.application(didFinishLaunchingWithOptions: launchOptions, window: window!)
    }
}
