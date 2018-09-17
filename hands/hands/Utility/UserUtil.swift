//
//  UserUtil.swift
//  hands
//
//  Created by 山浦功 on 2018/05/07.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import Foundation
import Firebase

public struct UserUtil {
    
    private init(){}
    
    static func getUser(id: String, completion: @escaping (User?) -> Void) {
        let collectionRef = Firestore.firestore().collection("users")
        collectionRef.whereField("id", isEqualTo: id).getDocuments { (snapshot, error) in
            if let snapshot = snapshot {
                if snapshot.documents.isEmpty == true {
                    completion(nil)
                } else {
                    completion(User(dictionary: snapshot.documents[0].data()))
                }
            }else {
                print(error!.localizedDescription)
                completion(nil)
            }
        }
    }
    
    
    /// すべてのユーザーを返す
    ///
    /// - Returns: ただし、データが一つしかない場合は取得に失敗している
    static func getAllUsers(complition: ([User]) -> Void) {
        var users: [User] = []
        let semaphore = DispatchSemaphore(value: 0)
        let collectionRef = Firestore.firestore().collection("users")
        collectionRef.getDocuments { (snapshot, error) in
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    users.append(User(dictionary: document.data())!)
                }
            }else {
                print(error!.localizedDescription)
            }
            semaphore.signal()
        }
        semaphore.wait()
        complition(users)
    }
    
    static func putUser(id: String, user: User, complition: ((Bool) -> Void)?) {
        let collectionRef = Firestore.firestore().collection("users")
        collectionRef.document(id).setData(user.dictionary) { (error) in
            if error != nil {
                complition!(false)
            }else {
                complition!(true)
            }
        }
    }
}
