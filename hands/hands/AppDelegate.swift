//
//  AppDelegate.swift
//  hands
//
//  Created by 山浦功 on 2017/12/27.
//  Copyright © 2017年 KoYamaura. All rights reserved.
//

import UIKit
import LineSDK
import FBSDKCoreKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var userName: String?
    var statusMessage: String?
    var pictureURLString: String?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        let user = Auth.auth().currentUser
        
        let userDefault = UserDefaults.standard
        let dict = ["firstLaunch" : true]
        userDefault.register(defaults: dict)
        
        if userDefault.bool(forKey: "firstLaunch"){
            userDefault.set(false, forKey: "firstLaunch")
            
            //do first Launch action here
            let initalViewController = UIStoryboard(name: "LoginViewController", bundle: nil).instantiateInitialViewController()
            self.window?.rootViewController = initalViewController
            self.window?.makeKeyAndVisible()
        }
        
        if let user = user {
            if user.displayName == nil {
                //segue to EditUserInfoViewController
                let editUserInfoViewController = UIStoryboard(name: "EditUserInfoViewController", bundle: nil).instantiateInitialViewController()
                self.window?.rootViewController = editUserInfoViewController
                self.window?.makeKeyAndVisible()
            } else {
                //segue MainTabBarController
                let mainTabBarController = UIStoryboard(name: "MainTabBarController", bundle: nil).instantiateInitialViewController()
                self.window?.rootViewController = mainTabBarController
                self.window?.makeKeyAndVisible()
            }
        } else {
            // segue to loginViewController
            let loginViewController = UIStoryboard(name: "LoginViewController", bundle: nil).instantiateInitialViewController()
            self.window?.rootViewController = loginViewController
            self.window?.makeKeyAndVisible()
        }
        
        var ref: DatabaseReference!
        
        ref = Database.database().reference()
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

