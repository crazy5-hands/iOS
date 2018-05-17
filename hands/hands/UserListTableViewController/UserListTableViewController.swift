//
//  UserListTableViewController.swift
//  hands
//
//  Created by 山浦功 on 2018/05/03.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import UIKit
import Firebase

class UserListTableViewController: UITableViewController {

    var pattern: UserListDataPattern = .all
    var id: String = (Auth.auth().currentUser?.uid)!
    private var viewModel = UserListTableViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "UserTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "user")
        
        let refresh = UIRefreshControl()
        refresh.attributedTitle = NSAttributedString(string: "読み込み中")
        refresh.tintColor = .blue
        refresh.addTarget(self, action: #selector(self.refreshTable), for: .valueChanged)
        tableView.addSubview(refresh)
        self.refreshControl = refresh
        self.loadData()
    }
    
    @objc private func refreshTable() {
        self.refreshControl?.beginRefreshing()
        self.loadData()
        self.refreshControl?.endRefreshing()
    }
    
    private func loadData() {
        DispatchQueue.global(qos: .userInitiated).async {
            self.viewModel.getUserData(id: self.id, pattern: self.pattern, complition: { (result) in
                if result == true {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                        self.tableView.reloadData()
                    })
                }else {
                    DispatchQueue.main.async {
                        self.navigationItem.prompt = "ユーザーデータの取得に失敗しました"
                    }
                }
            })
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.getUserCount()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "user", for: indexPath) as! UserTableViewCell
        cell.updateCell(user: self.viewModel.getUserByNunber(number: indexPath.item))
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(60.0)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let next = UserDetailTableViewController()
        next.userId = self.viewModel.getUserByNunber(number: indexPath.item).id
        self.navigationController?.pushViewController(next, animated: true)
    }
}
