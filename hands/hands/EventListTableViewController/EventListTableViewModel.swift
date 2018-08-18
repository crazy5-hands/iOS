//
//  EventListTableViewModel.swift
//  hands
//
//  Created by 山浦功 on 2018/05/04.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import Foundation
import RxSwift




class EventListTableViewModel {
    
//    private var events: [Event] = []
    let events: Observable<[Event]>
    
    init(_ eventTypes: [EventType]) {
        for eventType in eventTypes {
            switch eventType {
            case let .own(id) :
                print(id)
            case let .follow(id):
                print("follow" + id)
            case let .follower(id):
                print("follower" + id)
            case let .join(id):
                print("join" + id)
            }
        }
    }
    
//    func getEventsByEventIds(eventIds: [String], complition: @escaping (Bool) -> Void) {
//        let group = DispatchGroup()
//        for eventId in eventIds {
//            group.enter()
//            EventUtil().getEventByEventId(eventId: eventId) { (event) in
//                if let event = event {
//                    self.events.append(event)
//                }
//                group.leave()
//            }
//        }
//        group.notify(queue: .main) {
//            if self.events.isEmpty != true {
//                complition(true)
//            } else {
//                complition(false)
//            }
//        }
//    }
//
//    func getEventCount() -> Int {
//        return self.events.count
//    }
//
//    func getEventByNumber(number: Int) -> Event {
//        return self.events[number]
//    }
//
//    private func orderByCreatedAt(events: [Event]) -> [Event]{
//        var rEvents = events
//        rEvents.sort { (first, second) -> Bool in
//            return first.created_at as Date > second.created_at as Date
//        }
//        return rEvents
//    }
}
