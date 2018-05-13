//
//  EventDetailTableViewModel.swift
//  hands
//
//  Created by 山浦功 on 2018/05/13.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import Foundation
import Firebase

class EventDetailTableViewModel {
    
    private var event: Event
    private var joiners: [User] = []
    private var author: User?
    private let db = Firestore.firestore()
    
    init() {
        self.event = Event(id: "", author_id: "", title: "", body: "", created_at: NSDate())
        self.author = User(id: "", username: "", note: "", photo: "")
    }
    
    func getData(event: Event, complition: @escaping (Bool) -> Void){
        self.event = event
        var joiners: [String] = []
        
        db.collection("joins").whereField("event_id", isEqualTo: self.event.id).getDocuments { (snapshot, error) in
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    joiners.append((Join(dictionary: document.data())?.user_id)!)
                }
            }else {
            }
        }
        
        for joinerId in joiners {
            if let user = UserUtil().getUser(id: joinerId) {
                self.joiners.append(user)
            }
        }
        
        if self.event.author_id != "" {
            if let user = UserUtil().getUser(id: self.event.author_id) {
                self.author = user
                complition(true)
            }
        }
    }
    
    func getEvent() -> Event {
        return self.event
    }
    
    func getAuthor() -> User? {
        return self.author
    }
    
    func getJoinerById(number: Int) -> User {
        return self.joiners[number]
    }
    
    func getJoinsCount() -> Int {
        return self.joiners.count
    }
}
