//
//  AppDelegate.swift
//  SayWhatYouWill
//
//  Created by ALEXANDRA SALVATORE on 4/15/17.
//  Copyright © 2017 RowOut. All rights reserved.

/* For this project, I used a combination of MVVM & DCI Architecture
 * The goal of the project was to make an app that uses the Yoda Speak API
 * to take text input and output what the API replies. 
 * This app does that. In order to add different api 'translation' clients, 
 * The coder would only have to write an API Client for that service (see YodaAPIClient),
 * ( can take advantage of the Networking client that wraps AFNetworking )
 * a TextManipulator (see YodaSaysContext) & TextManipulatorViewModel (see YodaSaysViewModel)
 * These files are all together are under 100 lines of code. 
 * 
 * TextManipulationViewController can be initialized with any instance of TextMainuplator
 * and it will take care of the input output styling.
 *
 *
 *
 */

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        /* uncomment line below to demonstrate different contexts
         * working with TextManipulationViewController
         */
       // let context = SelfLoveContext()
        let context = YodaSaysContext()
        if let window = window {
            let viewController = TextManipulationViewController(with: context)
            window.rootViewController = viewController
            window.backgroundColor = .white
            window.makeKeyAndVisible()
        }
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

