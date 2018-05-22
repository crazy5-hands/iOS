//
//  ProfileTableViewController.swift
//  hands
//
//  Created by 山浦功 on 2018/05/22.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import UIKit

class ProfileTableViewController: UITableViewController {

    private let kSectionUserDetail = 0
    private let kSectionFollow = 1
    private let kSectionFollower = 2
    private let kSectionOwn = 3
    private let kSectionJoin = 4
    private let kSectionCost = 5
    private var viewModel: ProfileViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.global(qos: .userInitiated).async {
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case kSectionUserDetail:
            return UITableViewAutomaticDimension
        case kSectionFollow:
            return 50.0
        case kSectionFollower:
            return 50.0
        case kSectionOwn:
            return 50.0
        case kSectionJoin:
            return 50.0
        case kSectionCost:
            return 170.0
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case kSectionUserDetail:
            let cell = tableView.dequeueReusableCell(withIdentifier: "userDetail") as! UserDetailTableViewCell
            return cell
        default:
            return UITableViewCell()
        }
    }
}
