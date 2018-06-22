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
                dispatchGroup.enter()
                firestore.collection("members").whereField("id", isEqualTo: group.id).getDocuments { (snapshot, error) in
                    if let snapshot = snapshot {
                        
                    } else {
                        print(error?.localizedDescription)
                        self.tableViewStatus = .error
                    }
                }
                dispatchGroup.leave()
                dispatchGroup.notify(queue: .main, execute: {
                    self.tableView.reloadData()
                })
            }
        } else {
            self.tableViewStatus = .error
            
        }
    }
}


enum TableViewStatus {
    case loading
    case error
    case success
}
