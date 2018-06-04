//
//  UserDetailTableViewModel.swift
//  hands
//
//  Created by 山浦功 on 2018/05/17.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import Foundation
import Firebase

enum UserStatus {
    case follow
    case unrelated
    case me
    case error
}

class UserDetailTableVIewModel {
    
    private var user: User? = nil
    private var userStatus: UserStatus?
    private let db = Firestore.firestore()
    private var follows: [Follow] = []
    private var followers: [Follow] = []
    private let uid = Auth.auth().currentUser?.uid
    
    func getData(id: String, complition: @escaping (Bool) -> Void) {
        UserUtil().getUser(id: id) { (user) in
            if let user = user {
                self.user = user
                let group = DispatchGroup()
                let followUtil = FollowUtil()
                group.enter()
                followUtil.getFollows(user_id: id, complition: { (follows) in
                    self.follows = follows
                    group.leave()
                })
                group.enter()
                followUtil.getFollowers(follow_id: id, complition: { (followers) in
                    self.followers = followers
                    group.leave()
                })
                
                group.notify(queue: .main, execute: {
                    if let uid = self.uid {
                        if uid == user.id {
                            self.userStatus = .me
                        } else {
                            for follower in self.followers {
                                if follower.user_id == self.uid {
                                    self.userStatus = .follow
                                }
                            }
                            if self.userStatus != .follow {
                                self.userStatus = .unrelated
                            }
                        }
                    } else {
                        self.userStatus = .error
                    }
                    complition(true)
                })
            }else {
                self.userStatus = .error
                complition(false)
            }
        }
    }
    
    func getUserStatus() -> UserStatus? {
        return self.userStatus
    }
    
    func addFollow(complition: @escaping (Bool) -> Void) {
        if let uid = self.uid {
            if let followId = self.user?.id {
                for follower in self.followers {
                    if follower.user_id == uid {
                        complition(false)
                    }
                }
                let follow = Follow(id: UUID().uuidString, update_at: NSDate(), user_id: uid, follow_id: followId)
                FollowUtil().update(target: follow) { (result) in
                    complition(result)
                }
            }
        }
    }
    
    func getUser() -> User? {
        return self.user
    }
    
    func getFollowsCount() -> Int {
        return self.follows.count
    }
    
    func getFollowersCount() -> Int {
        return self.followers.count
    }
    
    func deleteFollow( complition: @escaping (Bool) -> Void) {
        let follow = self.followers.filter { (follow) -> Bool in
            follow.user_id == self.uid
        }
        if follow.count != 0 {
            FollowUtil().delete(target: follow[0]) { (result) in
                complition(result)
            }
        } else {
            complition(false)
        }
    }
}
