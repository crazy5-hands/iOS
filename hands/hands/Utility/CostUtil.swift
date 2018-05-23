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
    
    func getCostByEventId(eventId: String, complition: (Cost?) -> Void) {
        let db = Firestore.firestore()
        var cost: Cost? = nil
        let semaphore = DispatchSemaphore.init(value: 0)
        db.collection("costs").whereField("event_id", isEqualTo: eventId).getDocuments { (snapshot, error) in
            if let snapshot = snapshot {
                if snapshot.documents.count != 0 {
                    cost = Cost(dictionary: snapshot.documents[0].data())!
                }
            } else {
                print(error!.localizedDescription)
            }
            semaphore.signal()
        }
        semaphore.wait()
        complition(cost)
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
        db.collection("costs").whereField("event_id", isEqualTo: target.event_id).getDocuments { (snapshot, error) in
            if let snapshot = snapshot {
                if snapshot.documents[0].exists == true {
                    let documentID = snapshot.documents[0].documentID
                    db.collection("costs").document(documentID).delete(completion: { (error) in
                        if let error = error {
                            print(error.localizedDescription)
                            complition(true)
                        } else {
                            complition(false)
                        }
                    })
                } else {
                    complition(false)
                }
            } else {
                complition(false)
            }
        }
    }
}
