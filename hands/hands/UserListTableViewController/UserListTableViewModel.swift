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
    private var follows: [Follow] = []
    private let uid = Auth.auth().currentUser?.uid
    private var status: [String : UserStatus] = [:]
    
    func getAllUsers(complition: @escaping (Bool) -> Void) {
        UserUtil().getAllUsers(complition: { (users) in
            if users.count == 0 {
                complition(false)
            } else {
                self.users = users
                let group = DispatchGroup()
                for user in self.users {
                    if user.id == self.uid! {
                        self.status.updateValue(.me, forKey: user.id)
                    } else {
                        let db = Firestore.firestore()
                        db.collection("follows").whereField("follow_id", isEqualTo: user.id).whereField("user_id", isEqualTo: self.uid!).getDocuments { (snapshot, error) in
                            if let snapshot = snapshot {
                                if snapshot.documents.count != 0 {
                                    self.status.updateValue(.follow, forKey: user.id)
                                } else {
                                    self.status.updateValue(.unrelated, forKey: user.id)
                                }
                            } else {
                                print(error!.localizedDescription)
                                self.status.updateValue(.error, forKey: user.id)
                            }
                        }
                    }
                }
                group.notify(queue: .main) {
                    complition(true)
                }
            }
        })
    }
    
    func getUsersData(userIds: [String], complition: @escaping (Bool) -> Void) {
        let group = DispatchGroup()
        var newUsers: [User] = []
        var newStatus: [UserStatus] = []
        
        if userIds.isEmpty == true {
            complition(false)
        }
        for userId in userIds {
            group.enter()
            UserUtil().getUser(id: userId) { (user) in
                if let user = user {
                    group.enter()
                    var status: UserStatus = .error
                    
                    if user.id == self.uid {
                        status = .me
                        newStatus.append(status)
                    } else {
                        group.enter()
                        FollowUtil().getFollowers(follow_id: user.id, complition: { (followers) in
                            for follower in followers {
                                if follower.user_id == self.uid {
                                    status = .follow
                                }
                            }
                            if status == .error {
                                status = .unrelated
                            }
                            newStatus.append(status)
                            group.leave()
                        })
                    }
                    
                    newUsers.append(user)
                    group.leave()
                }
                group.leave()
            }
        }
        group.notify(queue: .main) {
            self.users = newUsers
            complition(true)
        }
    }
    
    func getUserCount() -> Int {
        return self.users.count
    }
    
    func getUserByNunber(number: Int) -> User {
        return self.users[number]
    }
    
    func getStatus(number: Int) -> UserStatus {
        let targetUser = self.users[number]
        return self.status[targetUser.id]!
    }
    
//    func getStatus(targetUserId: String) -> UserStatus {
//        var status: UserStatus?
//        if self.
//        FollowUtil().getFollowers(follow_id: targetUserId) { (followers) in
//            for follower in followers {
//                if follower.user_id == self.uid {
//
//                } else {
//                }
//            }
//        }
//    }
}
