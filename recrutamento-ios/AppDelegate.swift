//
//  AppDelegate.swift
//  recrutamento-ios
//
//  Created by Vinicius Carvalho on 20/01/16.
//  Copyright © 2016 Vinicius Carvalho. All rights reserved.
//

import UIKit
import ReachabilitySwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        let reachability : Reachability
        do {
            reachability = try Reachability.reachabilityForInternetConnection()
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "reachability", name: ReachabilityChangedNotification, object: reachability)
            
        } catch {
            print("Unable to create Reachability")
        }

        return true
    }
}

