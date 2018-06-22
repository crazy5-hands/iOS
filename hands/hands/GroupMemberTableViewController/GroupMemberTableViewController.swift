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
    
    let group: Group?
    let tableViewStatus: TableViewStatus = .loading
    
    override func getData() {
        if let group = self.group {
            let firestore = Firestore.firestore()
            let groupRef = firestore.collection("groups")
            groupRef.whereField("id", isEqualTo: group.id).getDocuments { (snapshot, error) in
                if let snapshot = snapshot {
                } else {
                    print(error?.localizedDescription)
                    self.tableViewStatus = .error
                }
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
