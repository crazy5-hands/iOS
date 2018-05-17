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
    
    private var users: [User] = []
    private let db = Firestore.firestore()
    
    func getUserData(id: String, pattern: UserListDataPattern, complition: @escaping (Bool) -> Void) {
        if self.users.count != 0 {
            self.users.removeAll()
        }
        switch pattern {
        case .follow:
            FollowUtil().getFollows(user_id: id) { (follows) in
                if follows.isEmpty != true {
                    let group = DispatchGroup()
                    group.enter()
                    for follow in follows {
                        group.enter()
                        UserUtil().getUser(id: follow.follow_id, completion: { (user) in
                            if let user = user {
                                self.users.append(user)
                            }
                            group.leave()
                        })
                    }
                    group.leave()
                    group.notify(queue: .main, execute: {
                        complition(true)
                    })
                }else {
                    complition(false)
                }
            }
        case .follower:
            FollowUtil().getFollowers(follow_id: id) { (followers) in
                if followers.isEmpty != true {
                    let group = DispatchGroup()
                    group.enter()
                    for follower in followers {
                        group.enter()
                        UserUtil().getUser(id: follower.user_id, completion: { (user) in
                            if let user = user {
                                self.users.append(user)
                            }
                            group.leave()
                        })
                    }
                    group.leave()
                    group.notify(queue: .main, execute: {
                        complition(true)
                    })
                }else {
                    complition(false)
                }
            }
        case .all:
            self.users =  UserUtil().getAllUsers()
            if self.users.count != 0 {
                complition(true)
            }else {
                complition(false)
            }
        }
    }
    
    func getUserCount() -> Int {
        return self.users.count
    }
    
    func getUserByNunber(number: Int) -> User {
        return self.users[number]
    }
}
