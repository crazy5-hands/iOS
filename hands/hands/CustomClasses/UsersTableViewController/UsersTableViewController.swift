//
//  UsersTableViewController.swift
//  hands
//
//  Created by 山浦功 on 2018/06/23.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import UIKit

/// This UsersTVC is base TVC to show user list.
class UsersTableViewController: UITableViewController {

    var users: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.refreshControl?.attributedTitle = NSAttributedString(string: "読み込み中")
        self.refreshControl?.tintColor = .black
        self.refreshControl?.addTarget(self, action: #selector(self.getData), for: .valueChanged)
        let userNib = UINib(nibName: "UserTableViewCell", bundle: nil)
        self.tableView.register(userNib, forCellReuseIdentifier: "user")
        self.getData()
    }
    
    func getData() {
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "user", for: indexPath) as! UserTableViewCell
        let user = self.users[indexPath.row]
        cell.updateCell(user: user)
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(50)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let next = UserDetailTableViewController()
        let targetUser = self.users[indexPath.row]
        next.userId = targetUser.id
        self.navigationController?.pushViewController(next, animated: true)
    }
}
