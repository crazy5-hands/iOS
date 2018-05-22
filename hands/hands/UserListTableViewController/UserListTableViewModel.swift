//
//  UserListTableViewModel.swift
//  hands
//
//  Created by 山浦功 on 2018/05/07.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import Foundation
import Firebase

class UserListTableViewModel {
    
    private var users: [User] = []
    private let db = Firestore.firestore()
    
    func getAllUsers(complition: (Bool) -> Void) {
        self.users = UserUtil().getAllUsers()
        if self.users.count == 0 {
            complition(false)
        } else {
            complition(true)
        }
    }
    
    func getUsersData(userIds: [String], complition: @escaping (Bool) -> Void) {
        let group = DispatchGroup()
        for userId in userIds {
            group.enter()
            UserUtil().getUser(id: userId) { (user) in
                if let user = user {
                    self.users.append(user)
                }
                group.leave()
            }
        }
        group.notify(queue: .main) {
            complition(true)
        }
    }
    
    func getUserCount() -> Int {
        return self.users.count
    }
    
    func getUserByNunber(number: Int) -> User {
        return self.users[number]
    }
}
