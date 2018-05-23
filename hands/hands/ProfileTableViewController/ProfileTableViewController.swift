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
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .black
        refreshControl.attributedTitle = NSAttributedString(string: "読み込み中")
        refreshControl.addTarget(self, action: #selector(self.loadData), for: .valueChanged)
        self.tableView.addSubview(refreshControl)
        self.refreshControl = refreshControl
        self.loadData()
    }
    
    
    func loadData() {
        self.startLoading()
        DispatchQueue.global(qos: .userInitiated).async {
            self.viewModel.loadData(complition: { (result) in
                if result == true {
                    DispatchQueue.main.async {
                        self.endLaoding()
                        self.tableView.reloadData()
                    }
                } else {
                    DispatchQueue.main.async {
                        self.endLaoding()
                        self.navigationItem.prompt = "データの取得ができませんでした。"
                    }
                }
            })
        }
    }
    
    func startLoading() {
        self.refreshControl?.beginRefreshing()
    }
    
    func endLaoding() {
        self.refreshControl?.endRefreshing()
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
            cell.selectionStyle = .none
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
            cell.selectionStyle = .none
            cell.update(cost: self.viewModel.getCost())
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case kSectionOwn:
            let next = EventListTableViewController()
            next.eventIds = self.viewModel.getOwnEventIds()
            self.navigationController?.pushViewController(next, animated: true)
        case kSectionJoin:
            let next = EventListTableViewController()
            next.eventIds = self.viewModel.getJoinEventIds()
            self.navigationController?.pushViewController(next, animated: true)
        case kSectionFollow:
            let next = FollowListTableViewController()
            next.userId = self.viewModel.getUser()?.id
            self.navigationController?.pushViewController(next, animated: true)
        case kSectionFollower:
            let next = FollowerListTableViewController()
            next.userId = self.viewModel.getUser()?.id
            self.navigationController?.pushViewController(next, animated: true)
        default:
            break
        }
    }
}
