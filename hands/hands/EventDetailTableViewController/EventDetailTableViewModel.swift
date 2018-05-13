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
    
    func getData(event: Event, complition: @escaping (Bool) -> Void){
        self.event = event
        let db = Firestore.firestore()
        
        db.collection("joins").whereField("event_id", isEqualTo: self.event.id).getDocuments { (snapshot, error) in
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    self.joins.append(Join(dictionary: document.data())!)
                }
            }else {
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
