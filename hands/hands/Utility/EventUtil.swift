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
    
    //APIの種類を設定
    let router = APIRouter.events
    
    func getOwnEvents(authorId: String, complition: @escaping ([Event]) -> Void) {
        self.router.collectionRef().whereField("author_id", isEqualTo: authorId).getDocuments { (snapshot, error) in
            var events: [Event] = []
            if let snapshot = snapshot {
                if snapshot.documents.isEmpty != true {
                    let decoder = JSONDecoder()
                    for document in snapshot.documents {
                        print(document.data())
                        let event = try! decoder.decode(Event.self, withJSONObject: document.data())
//                        let event = try! decoder.decode(Event.self, from: document.data())
                        events.append(event)
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
        self.router.collectionRef().whereField("id", isEqualTo: id).getDocuments { (snapshot, error) in
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
        self.router.collectionRef().whereField("id", isEqualTo: eventId).getDocuments { (snapshot, error) in
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
        self.router.collectionRef().getDocuments { (snapshot, error) in
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
        self.router.collectionRef().document(target.id).setData(target.dictionary) { (error) in
            if let error = error {
                print(error.localizedDescription)
                complition(false)
            }else {
                complition(true)
            }
        }
    }
    
    func delete(target: Event, complition: @escaping (Bool) -> Void) {
        self.router.collectionRef().document(target.id).delete { (error) in
            if error != nil {
                complition(false)
            } else {
                complition(true)
            }
        }
    }
 }
