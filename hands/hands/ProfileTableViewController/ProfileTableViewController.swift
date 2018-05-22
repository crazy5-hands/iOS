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
    private let kSectionOwn = 1
    private let kSectionJoin = 2
    private let kSectionFollow = 3
    private let kSectionFollower = 4
    private let kSectionCost = 5
    private var viewModel = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let userDetailNib = UINib(nibName: "UserDetailTableViewCell", bundle: nil)
        let followNib = UINib(nibName: "FollowCountTableViewCell", bundle: nil)
        let costNib = UINib(nibName: "CostTableViewCell", bundle: nil)
        self.tableView.register(userDetailNib, forCellReuseIdentifier: "userDetail")
        self.tableView.register(followNib, forCellReuseIdentifier: "follow")
        self.tableView.register(costNib, forCellReuseIdentifier: "cost")
        self.loadData()
    }
    
    func loadData() {
        DispatchQueue.global(qos: .userInitiated).async {
            self.viewModel.loadData(complition: { (result) in
                if result == true {
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } else {
                    DispatchQueue.main.async {
                        self.navigationItem.prompt = "データの取得ができませんでした。"
                    }
                }
            })
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
        case kSectionOwn:
            return 50.0
        case kSectionJoin:
            return 50.0
        case kSectionFollow:
            return 50.0
        case kSectionFollower:
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
            if let user = self.viewModel.getUser() {
                cell.updateCell(user: user)
            }
            return cell
        case kSectionOwn:
            let cell = tableView.dequeueReusableCell(withIdentifier: "follow") as! FollowCountTableViewCell
            cell.updateCell(title: "投稿イベント", count: (self.viewModel.getOwnsCount()))
            return cell
        case kSectionJoin:
            let cell = tableView.dequeueReusableCell(withIdentifier: "follow") as! FollowCountTableViewCell
            cell.updateCell(title: "参加イベント", count: (self.viewModel.getJoinsCount()))
            return cell
        case kSectionFollow:
            let cell = tableView.dequeueReusableCell(withIdentifier: "follow") as! FollowCountTableViewCell
            cell.updateCell(title: "フォロー", count: (self.viewModel.getFollowsCount()))
            return cell
        case kSectionFollower:
            let cell = tableView.dequeueReusableCell(withIdentifier: "follow") as! FollowCountTableViewCell
            cell.updateCell(title: "フォロワー", count: (self.viewModel.getFollowersCount()))
            return cell
        case kSectionCost:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cost") as! CostTableViewCell
            cell.update(cost: self.viewModel.getCost())
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
