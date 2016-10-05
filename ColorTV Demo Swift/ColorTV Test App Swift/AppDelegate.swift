//
//  AppDelegate.swift
//  ColorTV Test App Swift
//
//  Created by Jordan Jasinski on 10/02/16.
//  Copyright © 2016 Jordan Jasinski. All rights reserved.
//

import UIKit

import COLORAdFramework

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        COLORAdController.sharedAdController().start(withAppIdentifier: "08271056-5211-4ae6-bf1c-12e344455383")
        
        return true
    }

}

