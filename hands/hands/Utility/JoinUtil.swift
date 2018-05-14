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
    func getJoinerIdByEventId(eventId: String) -> [String] {
        let db = Firestore.firestore()
        var joinersId: [String] = []
        
        db.collection("joins").whereField("event_id", isEqualTo: eventId).getDocuments { (snapshot, error) in
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    joinersId.append(Join(dictionary: document.data())!.user_id)
                }
            }else {
                print(error!.localizedDescription)
            }
        }
        return joinersId
    }
}
