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
    private var viewModel: UserListTableViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "UserTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "user")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = title
        self.viewModel.getUserData(id: self.id, pattern: self.pattern) { (result) in
            if result == true {
                self.tableView.reloadData()
            }else {
                print("error user list tableviewcontroller")
            }
        } 
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.users.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "user", for: indexPath) as! UserTableViewCell
        cell.nameLabel.text = self.viewModel.users[indexPath.row].username
//        cell.profileImageView.image =
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(60.0)
    }
}
