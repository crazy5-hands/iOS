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
        DispatchQueue.global(qos: .userInitiated).async {
            if let id = self.userId {
                self.viewModel.getData(id: id, complition: { (result) in
                    if result == true {
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }else {
                        DispatchQueue.main.async {
                            self.navigationItem.prompt = "情報取得に失敗しました。"
                        }
                    }
                })
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
            return cell
        case kSectionFollow:
            let cell = tableView.dequeueReusableCell(withIdentifier: "follow")!
            return cell
        case kSectionFollower:
            let cell = tableView.dequeueReusableCell(withIdentifier: "follower")!
            return cell
        default:
            let cell = UITableViewCell()
            cell.sizeThatFits(.zero)
            return cell
        }
    }
    
}
