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
    
    func getUserData(id: String, pattern: UserListDataPattern, complition: (Bool) -> Void) {
        var result: Bool = false
        if self.users.count != 0 {
            self.users.removeAll()
        }
        switch pattern {
        case .follow:
            self.db.collection("follows").whereField("user_id", isEqualTo: id).getDocuments { (snapshot, error) in
                if let snapshot = snapshot {
                    var follows: [Follow] = []
                    for document in snapshot.documents {
                        follows.append(Follow(dictionary: document.data())!)
                    }
                    for follow in follows {
                        if let user =  UserUtil().getUser(id: follow.follow_id) {
                            self.users.append(user)
                        }
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
                    var followers: [Follow] = []
                    for document in snapshot.documents {
                        followers.append(Follow(dictionary: document.data())!)
                    }
                    for follower in followers {
                        if let user = UserUtil().getUser(id: follower.user_id) {
                            self.users.append(user)
                        }
                    }
                    result = true
                }else {
                    result = false
                    print(error!.localizedDescription)
                }
            }
        case .all:
            self.users =  UserUtil().getAllUsers()
            if self.users.count == 0 {
                result = false
            }else {
                result = true
            }
        }//end switch
        complition(result)
    }//end function
}
