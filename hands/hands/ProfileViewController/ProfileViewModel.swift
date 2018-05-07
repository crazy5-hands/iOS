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
    func errorToGetData()
}

class ProfileViewModel {
    
    var user: User? = nil
    var owns: [String] = []
    var joins: [String] = []
    var follows: [String] = []
    var followers: [String] = []
    var profilePhoto: UIImage? = nil
    private let db = Firestore.firestore()
    private let storage = Storage.storage()
    private var docRef: DocumentReference?
    private var eventRef: CollectionReference?
    private var followRef: CollectionReference?
    private var joinRef: CollectionReference?
    private var uid: String?
    var delegate: ProfileViewModelDelegate?
    
    init() {
        self.uid = (Auth.auth().currentUser?.uid)!
        self.docRef = db.collection("users").document(uid!)
        self.eventRef = db.collection("events")
        self.followRef = db.collection("follows")
        self.joinRef = db.collection("joins")
    }
    
    /// gettUserData expected to use when this viewmodel
    /// is initalize, or any chnage in userdata.
    ///
    /// - Parameter callback: Bool
    func getUserData(callback:@escaping (Bool) -> Void) {
        self.docRef?.getDocument(completion: { (document, error) in
            if document != nil {
                self.user = User(dictionary: (document?.data())!)!
//                self.photoRef = self.storageRef?.child((self.user?.photo)!)
                if self.user?.photo != "" {
                    self.profilePhoto = PhotoUtil().getPhoto(path: (self.user?.photo)!)
                }
                callback(true)
            }else {
                print(error?.localizedDescription ?? "error")
                callback(false)
            }
        })
    }
    
    func getAdditionalData(callback: (Bool) -> Void) {
        if self.uid != nil {
            // own
            self.owns.removeAll()
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
            self.joins.removeAll()
            self.joinRef?.whereField("user_id", isEqualTo: self.uid!).getDocuments { (snapshot, error) in
                if let snapshot = snapshot {
                    for document in snapshot.documents {
                        self.joins.append(document.data()["event_id"] as! String)
                    }
                }
            }
            //follow
            self.follows.removeAll()
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
            self.followers.removeAll()
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
            callback(true)
        }else {
            callback(false)
        }
    }
}
