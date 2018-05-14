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
        
        let eventListTableViewController = EventListTableViewController()
        eventListTableViewController.tabBarItem = UITabBarItem(title: "一覧", image: UIImage(named: "icon-list"), tag: 0)
        eventListTableViewController.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(self.segueToNewEvent))
        viewcontrollers.append(eventListTableViewController)
        
        let searchViewController = UIStoryboard(name: "SearchViewController", bundle: nil).instantiateInitialViewController()
//        searchViewController?.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 2)
        searchViewController?.tabBarItem = UITabBarItem(title: "検索", image: UIImage(named: "icon-search"), tag: 1)
//        viewcontrollers.append(searchViewController!)
        
        let userListTableViewController = UserListTableViewController()
        userListTableViewController.tabBarItem = UITabBarItem(title: "ユーザー", image: UIImage(named: "icon-users"), tag: 2)
        viewcontrollers.append(userListTableViewController)
        
        let notificationViewController = UIStoryboard(name: "NotificationViewController", bundle: nil).instantiateInitialViewController()
        notificationViewController?.tabBarItem = UITabBarItem(title: "通知", image: UIImage(named: "icon-notification"), tag: 3)
//        viewcontrollers.append(notificationViewController!)
        
        let profileViewController = UIStoryboard(name: "ProfileViewController", bundle: nil).instantiateInitialViewController()
        profileViewController?.tabBarItem = UITabBarItem(title: "プロフィール", image: UIImage(named: "icon-user"), tag: 4)
        profileViewController?.navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(self.openEditUserInfo)), animated: true)
        viewcontrollers.append(profileViewController!)
        self.viewControllers = viewcontrollers.map{ UINavigationController(rootViewController: $0)}
        
        self.setViewControllers(viewControllers, animated: false)
    }
    
    func segueToNewEvent() {
        let next = UIStoryboard(name: "NewEventViewController", bundle: nil).instantiateInitialViewController()
        self.present(next!, animated: true, completion: nil)
    }
    
    func openEditUserInfo(){
        let next = UIStoryboard(name: "EditUserInfoViewController", bundle: nil).instantiateInitialViewController()
        self.present(next!, animated: true, completion: nil)
    }
}
