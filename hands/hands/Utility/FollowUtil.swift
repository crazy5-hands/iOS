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
    
    func getFollowers(follow_id: String) -> [Follow] {
        var followers: [Follow] = []
        let db = Firestore.firestore().collection("follows")
        db.whereField("follow_id", isEqualTo: follow_id).getDocuments { (snapshot, error) in
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    followers.append(Follow(dictionary: document.data())!)
                }
            }else {
                print(error!.localizedDescription)
            }
        }
        return followers
    }
    
    func getFollows(user_id: String) -> [Follow] {
        var follows: [Follow] = []
        let db = Firestore.firestore().collection("follows")
        db.whereField("user_id", isEqualTo: user_id).getDocuments { (snapshot, error) in
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    follows.append(Follow(dictionary: document.data())!)
                }
            }else{
                print(error!.localizedDescription)
            }
        }
        return follows
    }
}
