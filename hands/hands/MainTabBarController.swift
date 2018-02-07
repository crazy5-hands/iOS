//
//  MainTabBarController.swift
//  hands
//
//  Created by 山浦功 on 2018/02/08.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import Foundation
import UIKit
import LineSDK

final class MainTabBarController: UITabBarController {
    
    var apiClient: LineSDKAPI?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let showEventsTableVC = UIStoryboard(name: "ShowEventsTableViewController", bundle: nil).instantiateViewController(withIdentifier: "showEventsViewController") as! ShowEventsTableViewController
        let showEventsNavigationController = UINavigationController(rootViewController: showEventsTableVC)
        
        let myEventsTableVC = UIStoryboard(name: "MyEventsTableViewController", bundle: nil).instantiateViewController(withIdentifier: "myEventsTableViewController") as! MyEventsTableViewController
        let myEventsNavigationController = UINavigationController(rootViewController: myEventsTableVC)
        
        let profileTableVC = UIStoryboard(name: "ProfileTableViewController", bundle: nil).instantiateViewController(withIdentifier: "profileTableViewController") as! ProfileTableViewController
        let profileNavigationController = UINavigationController(rootViewController: profileTableVC)
        
        self.setViewControllers([showEventsNavigationController, myEventsNavigationController, profileNavigationController], animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}