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
    private let uid = Auth.auth().currentUser?.uid
    private var cost: Cost?
    
    init() {
        self.event = Event(id: "", author_id: "", title: "", body: "", created_at: NSDate())
        self.author = User(id: "", username: "", note: "", photo: "")
    }
    
    func getData(event: Event, complition: @escaping (Bool) -> Void){
        let group = DispatchGroup()
        self.event = event
        group.enter()
        
        JoinUtil().getJoinerIdByEventId(eventId: event.id, complication: { (joinerIds) in
            for joinerId in joinerIds {
                group.enter()
                UserUtil.getUser(id: joinerId, completion: { (joiner) in
                    if let joiner = joiner {
                        self.joiners.append(joiner)
                    }
                    group.leave()
                })
            }
            group.leave()
        })
        
        group.enter()
        UserUtil.getUser(id: event.author_id, completion: { (user) in
            if let user = user {
                self.author = user
            }
            group.leave()
        })
        
        group.enter()
        CostUtil().getCostByEventId(eventId: event.id) { (cost) in
            if let cost = cost {
                self.cost = cost
            }
            group.leave()
        }
        
        group.notify(queue: .main, execute: {
            if self.author != nil {
                complition(true)
            }else {
                complition(false)
            }
        })
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
    
    func isAuthorMe() -> Bool {
        return self.event.author_id == self.uid
    }
    
    func isAlreadyJoin() -> Bool {
        return self.joiners.contains(where: { (joiner) -> Bool in
            return joiner.id == self.uid!
        })
    }
    
    func getCost() -> Int {
        if let cost = self.cost {
            return cost.cost
        } else {
            return 0
        }
    }
    
    func createJoin(complition: @escaping (Bool) -> Void) {
        let id = NSUUID().uuidString
        let eventId = self.event.id
        JoinUtil().createNewJoin(join: Join(id: id, event_id: eventId, user_id: self.uid!, created_at: NSDate()), complition: { (result) in
                if result == true {
                    complition(true)
                }else {
                    complition(false)
            }
        })
    }
}
