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
    
    func getEventById(id: String, complition: @escaping (Event?) -> Void) {
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
            complition(event)
        }
    }
    
    func getEventByEventId(eventId: String, complition: @escaping (Event?) -> Void) {
        let db = Firestore.firestore()
        db.collection("events").whereField("id", isEqualTo: eventId).getDocuments { (snapshot, error) in
            var event: Event? = nil
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    event = Event(dictionary: document.data())!
                }
            }
            complition(event)
        }
    }
    
    func getEventsAll(complition: @escaping ([Event]) -> Void) {
        let db = Firestore.firestore()
        db.collection("events").getDocuments { (snapshot, error) in
            var events: [Event] = []
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    events.append(Event(dictionary: document.data())!)
                }
            }
            complition(events)
        }
    }
    
    func updateEvent(target: Event, complition: @escaping (Bool) -> Void) {
        let db = Firestore.firestore()
        db.collection("events").document(target.id).setData(target.dictionary) { (error) in
            if let error = error {
                print(error.localizedDescription)
                complition(false)
            }else {
                complition(true)
            }
        }
    }
    
    func delete(target: Event, complition: @escaping (Bool) -> Void) {
        let db = Firestore.firestore()
        db.collection("events").document(target.id).delete { (error) in
            if error != nil {
                complition(false)
            } else {
                complition(true)
            }
        }
    }
 }
