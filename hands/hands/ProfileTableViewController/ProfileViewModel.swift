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
    private var costs: [Cost] = []
    
    func loadData(complition: @escaping (Bool) -> Void) {
        if self.uid == nil {
            complition(false)
        }
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
        JoinUtil().getJoinEventsByUserId(userId: self.uid!) { (joins) in
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
    
        for own in self.ownEventIds {
            group.enter()
            CostUtil().getCostByEventId(eventId: own) { (cost) in
                if let cost = cost {
                    self.costs.append(cost)
                }
                group.leave()
            }
        }
        
        for join in self.joins {
            group.enter()
            CostUtil().getCostByEventId(eventId: join.event_id) { (cost) in
                if let cost = cost {
                    self.costs.append(cost)
                }
                group.leave()
            }
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
        print("\(self.joins.count)")
        return self.joins.count
    }
    
    
    func getFollowsCount() -> Int {
        return self.followIds.count
    }
    
    func getFollowersCount() -> Int {
        return self.followerIds.count
    }
    
    func getCost() -> Int {
        var price = 0
        for cost in self.costs {
            price += cost.cost
        }
        return price
    }
}
