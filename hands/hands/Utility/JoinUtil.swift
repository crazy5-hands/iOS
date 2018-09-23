//
//  JoinUtil.swift
//  hands
//
//  Created by 山浦功 on 2018/05/14.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import Foundation
import Firebase

class JoinUtil {
    static func getJoinerIdByEventId(eventId: String, complication:@escaping ([String]) -> Void) {
        let db = Firestore.firestore()
        db.collection("joins").whereField("event_id", isEqualTo: eventId).getDocuments { (snapshot, error) in
            if let snapshot = snapshot {
                var result: [String] = []
                for document in snapshot.documents {
                    result.append(Join(dictionary: document.data())!.user_id)
                }
                complication(result)
            }else {
                print(error!.localizedDescription)
                let result: [String] = []
                complication(result)
            }
        }
    }
    
    static func createNewJoin(join: Join, complition: @escaping (Bool) -> Void) {
        let db = Firestore.firestore()
        db.collection("joins").addDocument(data: join.dictionary) { (error) in
            if error == nil {
                complition(true)
            }else {
                complition(false)
            }
        }
    }
    
    static func getJoinsByUserId(userId: String, complition: @escaping ([Join]) -> Void) {
        let db = Firestore.firestore()
        db.collection("joins").whereField("user_id", isEqualTo: userId).getDocuments { (snapshot, error) in
            var joins: [Join] = []
            if let snapshot = snapshot {
                if snapshot.documents.isEmpty != true {
                    for document in snapshot.documents {
                        joins.append(Join(dictionary: document.data())!)
                    }
                }
            } else {
                print(error!.localizedDescription)
                
            }
            complition(joins)
        }
    }
}
