//
//  EventListTableViewModel.swift
//  hands
//
//  Created by 山浦功 on 2018/05/04.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import Foundation
import Firebase

protocol EventListTableViewModelDelegate {
    func loadData()
    func errorToGetData()
}

class EventListTableViewModel {
    
    var events: [Event] = []
    private let uid = Auth.auth().currentUser?.uid
    private let db = Firestore.firestore()
    private var eventRef: CollectionReference?
    private var followRef: CollectionReference?
    var delegate: EventListTableViewModelDelegate?
    
    init() {
        self.eventRef = db.collection("events")
        self.followRef = db.collection("follows")
    }
    
    func loadEvents() {
        if self.events.count != 0 {
            self.events.removeAll()
        }
        self.getEvents(id: self.uid!) { (result) in
            if result == true {
                self.getFollowsEvents(callback: { (result) in
                    if result == true {
                        print("get follows")
                        self.orderByCreatedAt()
                        self.delegate?.loadData()
                    }else {
                        print("didn't get follows")
                        self.orderByCreatedAt()
                        self.delegate?.loadData()
                    }
                })
            }else {
                self.getFollowsEvents(callback: { (result) in
                    if result == true {
                        self.orderByCreatedAt()
                        self.delegate?.loadData()
                    }else {
                        self.delegate?.errorToGetData()
                    }
                })
            }
        }
    }
    
    private func getEvents(id: String, callback: @escaping (Bool) -> Void) {
        self.eventRef?.whereField("author_id", isEqualTo: id).getDocuments(completion: { (snapshot, error) in
            if let snapshot = snapshot {
                var events = [Event]()
                for document in snapshot.documents {
                    events.append(Event(dictionary: document.data())!)
                }
                self.events = self.events + events
                callback(true)
            }else {
                print(error?.localizedDescription ?? "error getOwnEvents")
                callback(false)
            }
        })
    }
    
    private func getFollowsEvents(callback: @escaping (Bool) -> Void ) {
        self.followRef?.whereField("user_id", isEqualTo: self.uid!).getDocuments(completion: { (snapshot, error) in
            if let snapshot = snapshot {
                var follows = [String]()
                for document in snapshot.documents {
                    follows.append(document.data()["follow_id"] as! String)
                }
                for follow in follows {
                    self.getEvents(id: follow, callback: { (result) in
                        if result == false {
                            print("false to get data  getFollowsEvents")
                        }
                    })
                }
                callback(true)
            }else {
                print(error?.localizedDescription ?? "error getfollowsEvents")
                callback(false)
            }
        })
    }
    
    private func orderByCreatedAt() {
        self.events.sort { (first, second) -> Bool in
            return first.created_at as Date > second.created_at as Date
        }
    }
}
