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
    case MainTabBarController = "MainTabBarController"
    
    //login
    case LoginViewController = "LoginViewController"
    case PasswordViewController = "PasswordViewÇontroller"
    case EmailViewController = "EmailViewController"
    case MyCostTableViewController = "MyCostTableViewController"
    
    //Info
    case ProfileViewController = "ProfileViewController"
    case PrivacyPolicyViewController = "PrivacyPolicyViewController"
    case UserDetailTableViewController = "UserDetailTableViewController"
    case EditUserInfoViewController = "EditUserInfoViewController"
    
    //Events
    case NewEventViewController = "NewEventViewController"
    case EventDetailViewController = "EventDetailViewController"
    case AllEventTableViewController = "AllEventTableViewController"
    case JoinEventListTableViewController = "JoinEventListTableViewController"
    case OwnEventListTableViewController = "OwnEventListTableViewController"
    case OwnFollowEventListTableViewController = "OwnFollowEventListTableViewController"
    
    
    //Cosy
    case EditCostViewController = "EditCostViewController"
    
    //Notification
    case NotificationViewController = "NotificationViewController"
    
    //else..
    case SearchViewController = "SearchViewController"
    case ListViewController = "ListViewController"
    
    //Storyboardより画面を呼び出す時に利用する。
    // ex) return Stortboard.PrivacyPolicyViewController.name
    var name: String {
        return self.rawValue
    }
}
