//
//  ProfileViewModel.swift
//  hands
//
//  Created by 山浦功 on 2018/05/02.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import Foundation
import Firebase

protocol ProfileViewModelDelegate {
    func loadData()
}

class ProfileViewModel {
    
    var user: User?
    var owns: [String] = []
    var joins: [String] = []
    var follows: [String] = []
    var followers: [String] = []
    private let db = Firestore.firestore()
    private var docRef: DocumentReference?
    private var eventRef: CollectionReference?
    private var followRef: CollectionReference?
    private var joinRef: CollectionReference?
    private var uid: String?
    var delegate: ProfileViewModelDelegate?
    
    init() {
        let displayName = Auth.auth().currentUser?.displayName
        self.uid = (Auth.auth().currentUser?.uid)!
        self.docRef = db.collection("users").document(displayName!)
        self.eventRef = db.collection("events")
        self.followRef = db.collection("follows")
        self.joinRef = db.collection("joins")
        self.user = User()
    }
    
    func getData(callback: (String?) -> Void) {

        //user
        self.docRef?.getDocument(completion: { (document, error) in
            if document != nil {
                self.user = User(dictionary: (document?.data())!)
                self.delegate?.loadData()
            }else {
                print(error?.localizedDescription ?? "error")
            }
        })
        if self.uid == nil {
            callback(self.uid)
        }
        
        // own
        self.eventRef?.whereField("author_id", isEqualTo: self.uid!).getDocuments { (snapshot, error) in
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    self.owns.append(document.data()["id"] as! String)
                }
            }else {
                print(error?.localizedDescription ?? "fail to get own's event")
            }
        }
        //join
        self.joinRef?.whereField("user_id", isEqualTo: self.uid!).getDocuments { (snapshot, error) in
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    self.joins.append(document.data()["event_id"] as! String)
                }
            }
        }
        //follow
        self.followRef?.whereField("user_id", isEqualTo: self.uid!).getDocuments { (snapshot, error) in
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    let id = document.data()["follow_id"] as? String
                    if id != nil {
                        self.follows.append(id!)
                    }
                }
            }else {
                print(error?.localizedDescription ?? "error follow")
            }
        }
        //follower
        self.followRef?.whereField("follow_id", isEqualTo: self.uid!).getDocuments { (snapshot, error) in
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    let id = document.data()["user_id"] as? String
                    if  id != nil {
                        self.followers.append(id!)
                    }
                }
            }else {
                print(error?.localizedDescription ?? "error follower")
            }
        }
        callback((self.user?.id)!)
//        self.delegate?.loadData()
    }
}
