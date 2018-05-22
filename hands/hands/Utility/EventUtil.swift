//
//  EventUtil.swift
//  hands
//
//  Created by 山浦功 on 2018/05/08.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import Foundation
import Firebase

class EventUtil {
    
    func getOwnEvents(authorId: String, complition: @escaping ([Event]) -> Void) {
        let db = Firestore.firestore()
        db.collection("events").whereField("author_id", isEqualTo: authorId).getDocuments { (snapshot, error) in
            var events: [Event] = []
            if let snapshot = snapshot {
                if snapshot.documents.isEmpty != true {
                    for document in snapshot.documents {
                        events.append(Event(dictionary: document.data())!)
                    }
                }
                complition(events)
            }else {
                print(error!.localizedDescription)
                complition(events)
            }
        }
    }
    
    func getEventById(id: String) -> Event? {
        var event: Event? = nil
        let db = Firestore.firestore()
        db.collection("events").whereField("id", isEqualTo: id).getDocuments { (snapshot, error) in
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    event = Event(dictionary: document.data())!
                }
            }else {
                print(error!.localizedDescription)
            }
        }
        return event
    }
}
