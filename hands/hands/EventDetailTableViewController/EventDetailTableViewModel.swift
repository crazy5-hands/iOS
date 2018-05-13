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
    private var joins: [Join] = []
    private var author: User?
    
    init() {
        self.event = Event(id: "", author_id: "", title: "", body: "", created_at: NSDate())
        self.author = User(id: "", username: "", note: "", photo: "")
    }
    
    func getData(eventId: String, complition: @escaping (Bool) -> Void){
        let db = Firestore.firestore()
        db.collection("events").whereField("event_id", isEqualTo: eventId).getDocuments { (snapshot, error) in
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    self.event = Event(dictionary: document.data())!
                }
                complition(true)
            }else{
                complition(false)
            }
        }
        
        db.collection("joins").whereField("event_id", isEqualTo: eventId).getDocuments { (snapshot, error) in
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    self.joins.append(Join(dictionary: document.data())!)
                }
                complition(true)
            }else {
                complition(false)
            }
        }
        if self.event.author_id != "" {
            db.collection("users").whereField("user_id", isEqualTo: self.event.author_id).getDocuments { (snapshot, error) in
                if let snapshot = snapshot {
                    for document in snapshot.documents {
                        self.author = User(dictionary: document.data())
                    }
                    complition(true)
                }else {
                    complition(false)
                }
            }
        }
    }
    
    func getEvent() -> Event {
        return self.event
    }
    
    func getAuthor() -> User? {
        return self.author
    }
    
    func getJoinsById(number: Int) -> Join {
        return self.joins[number]
    }
    
    func getJoinsCount() -> Int {
        return self.joins.count
    }
}
