//
//  Storyboard.swift
//  hands
//
//  Created by 山浦功 on 2018/08/30.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import Foundation

enum Storyboard: String {
    
    //Main
    case mainTabBarController = "MainTabBarController"
    case splashViewController = "SplashViewController"
    
    //login
    case loginViewController = "LoginViewController"
    case passwordViewController = "PasswordViewÇontroller"
    case emailViewController = "EmailViewController"
    
    //Info
    case ProfileViewController = "ProfileViewController"
    case PrivacyPolicyViewController = "PrivacyPolicyViewController"
    case UserDetailTableViewController = "UserDetailTableViewController"
    case EditUserInfoViewController = "EditUserInfoViewController"
    
    //Events
    case newEventViewController = "NewEventViewController"
    case eventDetailViewController = "EventDetailViewController"
    case allEventTableViewController = "AllEventTableViewController"
    case joinEventListTableViewController = "JoinEventListTableViewController"
    case ownEventListTableViewController = "OwnEventListTableViewController"
    case ownFollowEventListTableViewController = "OwnFollowEventListTableViewController"
    
    
    //Cosy
    case editCostViewController = "EditCostViewController"
    case myCostTableViewController = "MyCostTableViewController"
    
    //Notification
    case notificationViewController = "NotificationViewController"
    
    //else..
    case searchViewController = "SearchViewController"
    case listViewController = "ListViewController"
    
    //Storyboardより画面を呼び出す時に利用する。
    // ex) return Stortboard.PrivacyPolicyViewController.name
    var name: String {
        return self.rawValue
    }
}
