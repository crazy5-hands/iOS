//
//  FollowUtil.swift
//  hands
//
//  Created by 山浦功 on 2018/05/08.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import Foundation
import Firebase

class FollowUtil {
    
    func update(target: Follow, comlition: @escaping (Bool) -> Void) {
        let db = Firestore.firestore()
        db.collection("follows").document(target.id).setData(target.dictionary) { (error) in
            if let error = error {
                print(error.localizedDescription)
                comlition(false)
            } else {
                comlition(true)
            }
        }
    }
    
    func getFollowers(follow_id: String, complition: @escaping ([Follow]) -> Void) {
        var followers: [Follow] = []
        let db = Firestore.firestore().collection("follows")
        db.whereField("follow_id", isEqualTo: follow_id).getDocuments { (snapshot, error) in
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    followers.append(Follow(dictionary: document.data())!)
                }
            }
            complition(followers)
        }
    }
    
    
    
    func getFollows(user_id: String, complition: @escaping ([Follow]) -> Void) {
        var follows: [Follow] = []
        let db = Firestore.firestore().collection("follows")
        db.whereField("user_id", isEqualTo: user_id).getDocuments { (snapshot, error) in
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    follows.append(Follow(dictionary: document.data())!)
                }
            }
            complition(follows)
        }
    }
    
    func delete(target: Follow, complition: @escaping (Bool) -> Void) {
        let db = Firestore.firestore()
        db.collection("follows").document(target.id).delete { (error) in
            if let error = error {
                print(error.localizedDescription)
                complition(false)
            } else {
                complition(true)
            }
        }
    }
}
