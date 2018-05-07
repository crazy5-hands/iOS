//
//  UserUtil.swift
//  hands
//
//  Created by 山浦功 on 2018/05/07.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import Foundation
import Firebase

class UserUtil {
    
    func getUser(id: String) -> User? {
        var user: User? = nil
        let collectionRef = Firestore.firestore().collection("users")
        collectionRef.whereField("id", isEqualTo: id).getDocuments { (snapshot, error) in
            if let snapshot = snapshot {
                user = User(dictionary: snapshot.documents[0].data())
            }else {
                print(error!.localizedDescription)
            }
        }
        return user
    }
    
    
    /// すべてのユーザーを返す
    ///
    /// - Returns: ただし、データが一つしかない場合は取得に失敗している
    func getAllUsers() -> [User] {
        var users: [User] = []
        let collectionRef = Firestore.firestore().collection("users")
        collectionRef.getDocuments { (snapshot, error) in
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    users.append(User(dictionary: document.data())!)
                }
            }else {
                print(error!.localizedDescription)
            }
        }
        return users
    }
}
