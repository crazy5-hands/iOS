//
//  EventListTableViewModel.swift
//  hands
//
//  Created by 山浦功 on 2018/05/04.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import Foundation

class EventListTableViewModel {
    
    private var events: [Event] = []
    
    func getEventsByEventIds(eventIds: [String], complition: @escaping (Bool) -> Void) {
        let group = DispatchGroup()
        for eventId in eventIds {
            group.enter()
            EventUtil().getEventByEventId(eventId: eventId) { (event) in
                if let event = event {
                    self.events.append(event)
                }
                group.leave()
            }
        }
        group.notify(queue: .main) {
            if self.events.isEmpty != true {
                complition(true)
            } else {
                complition(false)
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
