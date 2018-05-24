//
//  UserDetailTableViewModel.swift
//  hands
//
//  Created by 山浦功 on 2018/05/17.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import Foundation
import Firebase

class UserDetailTableVIewModel {
    
    private var user: User? = nil
    private let db = Firestore.firestore()
    private var follows: [Follow] = []
    private var followers: [Follow] = []
    private let uid = Auth.auth().currentUser?.uid
    
    func getData(id: String, complition: @escaping (Bool) -> Void) {
        UserUtil().getUser(id: id) { (user) in
            if let user = user {
                self.user = user
                let group = DispatchGroup()
                let util = FollowUtil()
                group.enter()
                util.getFollows(user_id: id, complition: { (follows) in
                    self.follows = follows
                    group.leave()
                })
                group.enter()
                util.getFollowers(follow_id: id, complition: { (followers) in
                    self.followers = followers
                    group.leave()
                })
                group.notify(queue: .main, execute: {
                    complition(true)
                })
            }else {
                complition(false)
            }
        }
    }
    
    func isMe() -> Bool {
        if let user = self.user {
            if let uid = self.uid {
                return user.id == uid
            }
        }
        return false
    }
    
    func followedByMe() -> Bool {
        var result = false
        for follower in self.followers {
            if follower.user_id == self.uid {
                result = true
            }
        }
        return result
    }
    
    func addFollow(complition: @escaping (Bool) -> Void) {
        if let uid = self.uid {
            if let followId = self.user?.id {
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
}
