//
//  GroupMemberTableViewController.swift
//  hands
//
//  Created by 山浦功 on 2018/06/22.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import UIKit
import Firebase

class GroupMemberTableViewController: UsersTableViewController {
    
    var group: Group?
    
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
                            dispatchGroup.enter()
                            firestore.collection("users").whereField("id", isEqualTo: member.userId).getDocuments(completion: { (snapshot, error) in
                                if let snapshot = snapshot {
                                    let user = User(dictionary: snapshot.documents[0].data())
                                    if let user = user {
                                        users.append(user)
                                    }
                                    dispatchGroup.leave()
                                } else {
                                    dispatchGroup.leave()
                                }
                            })
                        }
                        
                        dispatchGroup.leave()
                    } else {
                        dispatchGroup.leave()
                    }
                }
                dispatchGroup.notify(queue: .main, execute: {
                    self.users = users
                    self.tableView.reloadData()
                })
            }
        } else {
            self.tableView.reloadData()
        }
    }
}
