//
//  MainTabBarController.swift
//  hands
//
//  Created by 山浦功 on 2018/04/26.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    private let tabColor = UIColor(red: 0.0, green: 255, blue: 0.0, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var viewcontrollers = [UIViewController]()
        
        let listViewController = UIStoryboard(name: "ListViewController", bundle: nil).instantiateInitialViewController()
        listViewController?.tabBarItem = UITabBarItem(title: "一覧", image: UIImage(named: "icon-list"), tag: 0)
        viewcontrollers.append(listViewController!)
        
        let searchViewController = UIStoryboard(name: "SearchViewController", bundle: nil).instantiateInitialViewController()
//        searchViewController?.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 2)
        searchViewController?.tabBarItem = UITabBarItem(title: "検索", image: UIImage(named: "icon-search"), tag: 1)
        viewcontrollers.append(searchViewController!)
        
        let notificationViewController = UIStoryboard(name: "NotificationViewController", bundle: nil).instantiateInitialViewController()
        notificationViewController?.tabBarItem = UITabBarItem(title: "通知", image: UIImage(named: "icon-notification"), tag: 2)
        viewcontrollers.append(notificationViewController!)
        
        let profileViewController = UIStoryboard(name: "ProfileViewController", bundle: nil).instantiateInitialViewController()
        profileViewController?.tabBarItem = UITabBarItem(title: "プロフィール", image: UIImage(named: "icon-user"), tag: 3)
        viewcontrollers.append(profileViewController!)
        self.viewControllers = viewcontrollers.map{ UINavigationController(rootViewController: $0)}
        
        self.setViewControllers(viewControllers, animated: false)
    }
}
