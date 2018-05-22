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
    private var owns: [String] = []
    private var joins: [String] = []
    private var follows: [String] = []
    private var followers: [String] = []
    private var cost: Cost?
    
    func loadData(complition: (Bool) -> Void) {
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
        group.leave()
        group.notify(queue: .main) {
            
        }
    }
    
    func getUser() -> User? {
        return self.user
    }
    
    func getOwnsCount() -> Int {
        return self.owns.count
    }
    
    func getJoinsCount() -> Int {
        return self.joins.count
    }
    
    func getFollowsCount() -> Int {
        return self.follows.count
    }
    
    func getFollowersCount() -> Int {
        return self.followers.count
    }
    
    func getCost() -> Int {
        if let cost = self.cost {
            return cost.cost
        }else {
            return 0
        }
    }
}
