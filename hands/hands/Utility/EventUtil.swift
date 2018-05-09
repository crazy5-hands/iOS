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
    
    func getOwnEvent(id: String) -> [Event] {
        var events: [Event] = []
        let db = Firestore.firestore()
        db.collection("events").whereField("author_id", isEqualTo: id).getDocuments { (snapshot, error) in
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    events.append(Event(dictionary: document.data())!)
                }
            }else {
                print(error!.localizedDescription)
            }
        }
        return events
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
