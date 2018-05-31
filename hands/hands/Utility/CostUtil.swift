//
//  CostUtil.swift
//  hands
//
//  Created by 山浦功 on 2018/05/21.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import Foundation
import Firebase

class CostUtil {
    
    func getCostByEventId(eventId: String, complition: @escaping (Cost?) -> Void) {
        let db = Firestore.firestore()
        var cost: Cost? = nil
        db.collection("costs").whereField("event_id", isEqualTo: eventId).getDocuments { (snapshot, error) in
            if let snapshot = snapshot {
                if snapshot.documents.count != 0 {
                    cost = Cost(dictionary: snapshot.documents[0].data())!
                }
            } else {
                print(error!.localizedDescription)
            }
            complition(cost)
        }
    }
    
    func update(target: Cost, complition: @escaping (Bool) -> Void) {
        let db = Firestore.firestore()
        db.collection("costs").document(target.id).setData(target.dictionary) { (error) in
            if let error = error {
                print(error.localizedDescription)
                complition(false)
            } else {
                complition(true)
            }
        }
    }
    
    func destroy(target: Cost, complition: @escaping (Bool) -> Void) {
        let db = Firestore.firestore()
        db.collection("costs").document(target.id).delete { (error) in
            if error == nil {
                complition(true)
            } else {
                complition(false)
            }
        }
    }
}
