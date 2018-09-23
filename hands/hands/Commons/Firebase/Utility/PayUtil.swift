//
//  PayUtil.swift
//  hands
//
//  Created by 山浦功 on 2018/05/22.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import Foundation
import Firebase

class PayUtil {
    
    /// get pays by Pay id
    ///
    /// - Parameters:
    ///   - id: id
    ///   - complition: when Pay is array, it successed to get data. when it is nil, it failed to get data
    func getPaysById(id: String, complition: @escaping ([Pay]?) -> Void){
        let db = Firestore.firestore()
        db.collection("pays").whereField("id", isEqualTo: id).getDocuments { (snapshot, error) in
            if let snapshot = snapshot {
                var pays: [Pay] = []
                if snapshot.documents.isEmpty == false {
                    for document in snapshot.documents {
                        pays.append(Pay(dictionary: document.data())!)
                    }
                }
                complition(pays)
            } else {
                print(error!.localizedDescription)
                complition(nil)
            }
        }
    }
    
    func getPaysByCostId(costId: String, complition: @escaping ([Pay]?) -> Void){
        let db = Firestore.firestore()
        db.collection("pays").whereField("event_id", isEqualTo: costId).getDocuments { (snapshot, error) in
            if let snapshot = snapshot {
                var pays: [Pay] = []
                if snapshot.documents.isEmpty == false {
                    for document in snapshot.documents {
                        pays.append(Pay(dictionary: document.data())!)
                    }
                }
                complition(pays)
            } else {
                print(error!.localizedDescription)
                complition(nil)
            }
        }
    }
    
    /// add or update pay data
    ///
    /// - Parameters:
    ///   - target: Pay
    ///   - complition: if it failed, boolean is false. Otherwise, it successed and you should get true.
    func updatePay(target: Pay, complition: @escaping (Bool) -> Void){
        let db = Firestore.firestore()
        db.collection("pays").document(target.id).setData(target.dictionary) { (error) in
            if let error = error {
                print(error.localizedDescription)
                complition(false)
            } else {
                complition(true)
            }
        }
    }
    
    func deletePay(target: Pay, complition: @escaping (Bool) -> Void){
        let db = Firestore.firestore()
        db.collection("pays").document(target.id).delete { (error) in
            if let error = error {
                print(error.localizedDescription)
                complition(false)
            } else {
                complition(true)
            }
        }
    }
}
