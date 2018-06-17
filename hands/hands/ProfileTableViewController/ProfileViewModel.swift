//
//  ProfileViewModel.swift
//  hands
//
//  Created by 山浦功 on 2018/05/02.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import Foundation
import Firebase

class ProfileViewModel {
    
    private let uid = Auth.auth().currentUser?.uid
    private var user: User?
    private var ownEventIds: [String] = [] //Event id
    private var joins: [Join] = [] //Join id
    private var followIds: [String] = [] //Follow
    private var followerIds: [String] = [] //Follow
    
    func loadData(complition: @escaping (Bool) -> Void) {
        if self.uid == nil {
            complition(false)
        }
        self.joins.removeAll()
        self.ownEventIds.removeAll()
        self.followIds.removeAll()
        self.followerIds.removeAll()
        
        let group = DispatchGroup()
        
        group.enter()
        UserUtil().getUser(id: self.uid!) { (user) in
            if let user = user {
                self.user = user
            }
            group.leave()
        }
        group.enter()
        EventUtil().getOwnEvents(authorId: self.uid!) { (events) in
            if events.isEmpty != true {
                for event in events {
                    self.ownEventIds.append(event.id)
                }
            }
            group.leave()
        }
        group.enter()
        JoinUtil().getJoinsByUserId(userId: self.uid!) { (joins) in
            self.joins = joins
            group.leave()
        }
        group.enter()
        FollowUtil().getFollows(user_id: self.uid!) { (follows) in
            if follows.isEmpty != true {
                for follow in follows {
                    self.followIds.append(follow.id)
                }
            }
            group.leave()
        }
        group.enter()
        FollowUtil().getFollowers(follow_id: self.uid!) { (follows) in
            if follows.isEmpty != true {
                for follow in follows {
                    self.followerIds.append(follow.id)
                }
            }
            group.leave()
        }
        
        group.notify(queue: .main) {
            complition(true)
        }
    }
    
    func getUser() -> User? {
        return self.user
    }
    
    func getOwnsCount() -> Int {
        return self.ownEventIds.count
    }
    
    func getOwnEventIds() -> [String] {
        return self.ownEventIds
    }
    
    func getJoinsCount() -> Int {
        return self.joins.count
    }
    
    func getJoinEventIds() -> [String] {
        var ids: [String] = []
        for join in self.joins {
            ids.append(join.event_id)
        }
        return ids
    }
    
    func getFollowsCount() -> Int {
        return self.followIds.count
    }
    
    func getFollowersCount() -> Int {
        return self.followerIds.count
    }
    
    func logout() {
        do {
            try? Auth.auth().signOut()
        } catch {
            
        }
    }
}
