//
//  MainTabBarController.swift
//  hands
//
//  Created by 山浦功 on 2018/04/26.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        var viewcontrollers = [UIViewController]()
        
        let listViewController = UIStoryboard(name: "MainViewController", bundle: nil).instantiateInitialViewController()
        listViewController?.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 1)
        viewcontrollers.append(listViewController!)
        
        let searchViewController = UIStoryboard(name: "SearchViewController", bundle: nil).instantiateInitialViewController()
        searchViewController?.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 2)
        viewcontrollers.append(searchViewController!)
        
        let notificationViewController = UIStoryboard(name: "NotificationViewController", bundle: nil).instantiateInitialViewController()
        notificationViewController?.tabBarItem = UITabBarItem(tabBarSystemItem: .featured, tag: 3)
        viewcontrollers.append(notificationViewController!)
        
        let profileViewController = UIStoryboard(name: "ProfileViewController", bundle: nil).instantiateInitialViewController()
        profileViewController?.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 4)
        viewcontrollers.append(profileViewController!)
        
        self.setViewControllers(viewControllers, animated: false)
    }
}
