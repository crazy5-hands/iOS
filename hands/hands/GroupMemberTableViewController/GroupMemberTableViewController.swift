//
//  GroupMemberTableViewController.swift
//  hands
//
//  Created by 山浦功 on 2018/06/22.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import UIKit
import Firebase

class GroupMemberTableViewController: UserListTableViewController {
    
    var group: Group?
    private var tableViewStatus: TableViewStatus?
    
    override func getData() {
        
        if let group = self.group {
            DispatchQueue.global(qos: .userInitiated).async {
                let dispatchGroup = DispatchGroup()
                let firestore = Firestore.firestore()
                var users: [User] = []
                dispatchGroup.enter()
                firestore.collection("members").whereField("id", isEqualTo: group.id).getDocuments { (snapshot, error) in
                    if let snapshot = snapshot {
                        for document in snapshot.documents {
                            let member = Member(dictionary: document.data())
                            firestore.collection("users").whereField("id", isEqualTo: member.userId).getDocuments(completion: { (snapshot, error) in
                                if let snapshot = snapshot {
                                    let user = User(dictionary: snapshot.documents[0].data())
                                    if let user = user {
                                        users.append(user)
                                    }
                                    dispatchGroup.leave()
                                } else {
                                    self.tableViewStatus = .error
                                    dispatchGroup.leave()
                                }
                            })
                        }
                        dispatchGroup.leave()
                    } else {
                        self.tableViewStatus = .error
                        dispatchGroup.leave()
                    }
                }
                dispatchGroup.notify(queue: .main, execute: {
                    self.viewModel.updateUsers(users: users)
                    self.tableView.reloadData()
                })
            }
        } else {
            self.tableViewStatus = .error
            self.tableView.reloadData()
        }
    }
}


enum TableViewStatus {
    case loading
    case error
    case success
}
