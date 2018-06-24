//
//  GroupTableViewController.swift
//  hands
//
//  Created by 山浦功 on 2018/06/24.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import UIKit
import Firebase

class GroupsTableViewController: UITableViewController {

    var groups:[Group] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.refreshControl?.attributedTitle = NSAttributedString(string: "読み込み中")
        self.refreshControl?.tintColor = .black
        self.refreshControl?.addTarget(self, action: #selector(self.getData), for: UIControlEvents.valueChanged)
        let groupNib = UINib(nibName: "UserTableViewCell", bundle: nil)
        self.tableView.register(groupNib, forCellReuseIdentifier: "group")
        self.getData()
    }
    
    func getData() {
        self.refreshControl?.beginRefreshing()
        DispatchQueue.global(qos: .userInitiated).async {
            let group = DispatchGroup()
            var newGroups: [Group] = []
            let firestore = Firestore.firestore()
            guard let uid = Auth.auth().currentUser?.uid else { return }
            firestore.collection("members").whereField("user_id", isEqualTo: uid).getDocuments(completion: { (snapshot, error) in
                if let snapshot = snapshot {
                    for document in snapshot.documents {
                        group.enter()
                        let belongGroup = document.data()["belong_to"] as! String
                        firestore.collection("groups").whereField("id", isEqualTo: belongGroup).getDocuments(completion: { (snapshot, error) in
                            if let snapshot = snapshot {
                                let new = Group(dictionary: snapshot.documents[0].data())
                                newGroups.append(new!)
                                group.leave()
                            } else {
                                group.leave()
                            }
                        })
                    }
                } else {
                    print("error")
                }
            })
            group.notify(queue: .main, execute: {
                self.groups = newGroups
                self.tableView.reloadData()
            })
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.groups.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "group", for: indexPath) as! UserTableViewCell
        let group = self.groups[indexPath.row]
        cell.updateCell(username: group.name, status: "")
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(70)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // write here next viewcontroller
    }
}
