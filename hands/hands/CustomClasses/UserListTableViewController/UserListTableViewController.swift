//
//  UserListTableViewController.swift
//  hands
//
//  Created by 山浦功 on 2018/05/03.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import UIKit
import Firebase

/// Usage
/// if you want to get particular users data, you have to override getData().
/// reloadData(): end refresh control and reload tableview
/// startLoading(): start refresh control
/// endLoading(): end refresh control
class UserListTableViewController: UITableViewController {

    var viewModel = UserListTableViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "UserTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "user")
        let refresh = UIRefreshControl()
        refresh.attributedTitle = NSAttributedString(string: "読み込み中")
        refresh.tintColor = .black
        refresh.addTarget(self, action: #selector(self.getData), for: .valueChanged)
        tableView.addSubview(refresh)
        self.refreshControl = refresh
        self.getData()
    }
    
    @objc func getData() {
        self.startLoading()
        DispatchQueue.global(qos: .userInitiated).async {
            self.viewModel.getAllUsers(complition: { (result) in
                if result == true {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                        self.endLaoding()
                        self.reloadData()
                    })
                } else {
                    DispatchQueue.main.async {
                        self.endLaoding()
                        self.navigationItem.prompt = "データの取得ができませんでした。"
                    }
                }
            })

        }
    }
    
    func reloadData() {
        self.refreshControl?.endRefreshing()
        self.tableView.reloadData()
    }
    
    func startLoading() {
        self.refreshControl?.beginRefreshing()
    }
    
    func endLaoding() {
        self.refreshControl?.endRefreshing()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.getUserCount()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "user", for: indexPath) as! UserTableViewCell
        let user = self.viewModel.getUserByNunber(number: indexPath.row)
        let status = self.viewModel.getStatus(number: indexPath.row)
        var statusString = ""
        switch status {
        case .follow:
            statusString = "フォロー中"
        default:
            break
        }
        cell.updateCell(username: user.username, status: statusString)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(50.0)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let next = UserDetailTableViewController()
        next.userId = self.viewModel.getUserByNunber(number: indexPath.item).id
        self.navigationController?.pushViewController(next, animated: true)
    }
}
