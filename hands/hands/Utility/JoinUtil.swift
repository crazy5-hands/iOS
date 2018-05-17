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
    func getJoinerIdByEventId(eventId: String, complication:@escaping ([String]) -> Void) {
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
    
    func createNewJoin(join: Join, complition: @escaping (Bool) -> Void) {
        let db = Firestore.firestore()
        db.collection("joins").addDocument(data: join.dictionary) { (error) in
            if error == nil {
                complition(true)
            }else {
                complition(false)
            }
        }
    }
}
