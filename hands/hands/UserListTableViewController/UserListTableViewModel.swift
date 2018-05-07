//
//  UserListTableViewModel.swift
//  hands
//
//  Created by 山浦功 on 2018/05/07.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import Foundation
import Firebase

enum UserListDataPattern {
    case follow
    case follower
    case all
}

class UserListTableViewModel {
    
    var users: [User] = []
    private let db = Firestore.firestore()
    
    func getUserData(id: String, pattern: UserListDataPattern, complition: (Bool?) -> Void) {
        var result: Bool? = nil
        if self.users.count != 0 {
            self.users.removeAll()
        }
        switch pattern {
        case .follow:
            self.db.collection("follows").whereField("user_id", isEqualTo: id).getDocuments { (snapshot, error) in
                if let snapshot = snapshot {
                    for document in snapshot.documents {
                        self.users.append(User(dictionary: document.data())!)
                    }
                    result = true
                }else {
                    result = false
                    print(error!.localizedDescription)
                }
            }
        case .follower:
            self.db.collection("follows").whereField("follow_id", isEqualTo: id).getDocuments { (snapshot, error) in
                if let snapshot = snapshot {
                    for document in snapshot.documents {
                        self.users.append(User(dictionary: document.data())!)
                    }
                    result = true
                }else {
                    result = false
                    print(error!.localizedDescription)
                }
            }
        case .all:
            self.db.collection("users").getDocuments { (snapshot, error) in
                if let snapshot = snapshot {
                    for document in snapshot.documents {
                        self.users.append(User(dictionary: document.data())!)
                    }
                    result = true
                }else {
                    print(error!.localizedDescription)
                    result = false
                }
            }
        }//end switch
        complition(result)
    }//end function
}
