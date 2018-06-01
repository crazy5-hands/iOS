//
//  UserDetailTableViewController.swift
//  hands
//
//  Created by 山浦功 on 2018/05/17.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import UIKit

class UserDetailTableViewController: UITableViewController {

    var userId: String?
    private let kSectionUser = 0
    private let kSectionFollow = 1
    private let kSectionFollower = 2
    private let viewModel = UserDetailTableVIewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.estimatedRowHeight = 140
        self.tableView.rowHeight = UITableViewAutomaticDimension
        let userNib = UINib(nibName: "UserDetailTableViewCell", bundle: nil)
        let followNib = UINib(nibName: "FollowCountTableViewCell", bundle: nil)
        self.tableView.register(followNib, forCellReuseIdentifier: "follow")
        self.tableView.register(userNib, forCellReuseIdentifier: "user")
        getData()
    }
    
    func getData() {
        DispatchQueue.global(qos: .userInitiated).async {
            if let id = self.userId {
                self.viewModel.getData(id: id, complition: { (result) in
                    if result == true {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                            self.reloadData()
                        })
                    }else {
                        DispatchQueue.main.async {
                            self.navigationItem.prompt = "情報取得に失敗しました。"
                        }
                    }
                })
            }
        }
    }
    
    func reloadData() {
        if self.viewModel.isMe() == false {
            if self.viewModel.followedByMe() == false {
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "フォロー", style: .done, target: self, action: #selector(self.addFollow))
            }
        }
        self.tableView.reloadData()
    }
    
    @objc func addFollow() {
        self.viewModel.addFollow { (result) in
            if result == true {
                self.getData()
            } else {
                self.showAlert("何らかの原因でフォローに失敗しました。")
            }
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        if self.viewModel.getUser() == nil {
            return 0
        }else {
            return 3
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case kSectionUser:
            return 1
        case kSectionFollow:
            return 1
        case kSectionFollower:
            return 1
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case kSectionUser:
            let cell = tableView.dequeueReusableCell(withIdentifier: "user") as! UserDetailTableViewCell
            if let user = self.viewModel.getUser() {
                cell.updateCell(user: user)
            }
            cell.selectionStyle = .none
            return cell
        case kSectionFollow:
            let cell = tableView.dequeueReusableCell(withIdentifier: "follow")! as! FollowCountTableViewCell
            let count = self.viewModel.getFollowsCount()
            cell.updateCell(title: "フォロー", count: count)
            if count == 0 {
                cell.selectionStyle = .none
            }
            return cell
        case kSectionFollower:
            let cell = tableView.dequeueReusableCell(withIdentifier: "follow") as! FollowCountTableViewCell
            let count = self.viewModel.getFollowersCount()
            cell.updateCell(title: "フォロワー", count: count)
            if count == 0 {
                cell.selectionStyle = .none
            }
            return cell
        default:
            let cell = UITableViewCell()
            cell.sizeThatFits(.zero)
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case kSectionFollow:
            if self.viewModel.getFollowsCount() != 0 {
                if let id = self.viewModel.getUser()?.id {
                    let next = FollowListTableViewController()
                    next.userId = id
                    self.navigationController?.pushViewController(next, animated: true)
                }
            }
        case kSectionFollower:
            if self.viewModel.getFollowersCount() != 0 {
                if let id = self.viewModel.getUser()?.id {
                    let next = FollowerListTableViewController()
                    next.userId = id
                    self.navigationController?.pushViewController(next, animated: true)
                }
            }
        default:
            break
        }
    }
    
}
