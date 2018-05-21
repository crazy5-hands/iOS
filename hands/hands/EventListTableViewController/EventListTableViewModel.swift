//
//  EventListTableViewModel.swift
//  hands
//
//  Created by 山浦功 on 2018/05/04.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import Foundation
import Firebase

enum EventDataPattern {
    case own
    case join
    case all
    case ownAndfollow
}

class EventListTableViewModel {
    
    private var events: [Event] = []
    
    func getEvents(id: String, dataPattern: EventDataPattern, complition: @escaping (Bool) -> Void) {
        var newEvents: [Event] = []
        let db = Firestore.firestore()
        switch dataPattern {
        case .own:
            newEvents = EventUtil().getOwnEvent(id: id)
            self.events = newEvents
            complition(true)
        case .join:
            var joins: [Join] = []
            db.collection("joins").whereField("user_id", isEqualTo: id).getDocuments { (snapshot, error) in
                if let snapshot = snapshot {
                    for document in snapshot.documents {
                        joins.append(Join(dictionary: document.data())!)
                    }
                    for join in joins {
                        if let event = EventUtil().getEventById(id: join.event_id){
                            newEvents.append(event)
                        }
                    }
                    self.events = newEvents
                    complition(true)
                }else {
                    complition(false)
                }
            }
        case .all:
            db.collection("events").getDocuments { (snapshot, error) in
                if let snapshot = snapshot {
                    for document in snapshot.documents {
                        newEvents.append(Event(dictionary: document.data())!)
                    }
                    newEvents.sort(by: {$0.created_at.timeIntervalSinceNow > $1.created_at.timeIntervalSinceNow})
                    self.events = newEvents
                    complition(true)
                }else {
                    print(error!.localizedDescription)
                    complition(false)
                }
            }
        case .ownAndfollow:
            newEvents = EventUtil().getOwnEvent(id: id)
            FollowUtil().getFollows(user_id: id) { (follows) in
                if follows.isEmpty != true {
                    for follow in follows {
                        let fEvents = EventUtil().getOwnEvent(id: follow.follow_id)
                        newEvents = newEvents + fEvents
                    }
                    self.events = newEvents
                    complition(true)
                } else {
                    complition(false)
                }
            }
        }
    }
    
    func getEventCount() -> Int {
        return self.events.count
    }
    
    func getEventByNumber(number: Int) -> Event {
        return self.events[number]
    }
    
    private func orderByCreatedAt(events: [Event]) -> [Event]{
        var rEvents = events
        rEvents.sort { (first, second) -> Bool in
            return first.created_at as Date > second.created_at as Date
        }
        return rEvents
    }
}
