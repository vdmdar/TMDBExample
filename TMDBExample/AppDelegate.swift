//
//  AppDelegate.swift
//  TMDBExample
//
//  Created by ss on 09/02/2018.
//  Copyright © 2018 ss. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        API.getMovie()
        
        return true
    }


}

