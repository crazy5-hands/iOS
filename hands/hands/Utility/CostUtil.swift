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
    
    func create(newCost: Cost, complition: @escaping (Bool) -> Void) {
        let db = Firestore.firestore()
        db.collection("costs").addDocument(data: newCost.dictionary) { (error) in
            if let error = error {
                print(error.localizedDescription)
                complition(false)
            } else {
                complition(true)
            }
        }
    }
    
    func update(target: Cost, complition: @escaping (Bool) -> Void) {
        let db = Firestore.firestore()
        db.collection("costs").whereField("event_id", isEqualTo: target.event_id).getDocuments { (snapshot, error) in
            if let snapshot = snapshot {
                if snapshot.documents[0].exists == true {
                    let documentID = snapshot.documents[0].documentID
                    db.collection("costs").document(documentID).setData(target.dictionary, completion: { (error) in
                        if let error = error {
                            print(error.localizedDescription)
                            complition(false)
                        } else {
                            complition(true)
                        }
                    })
                } else {
                    complition(false)
                }
                complition(false)
            } else {
                print(error!.localizedDescription)
                complition(false)
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