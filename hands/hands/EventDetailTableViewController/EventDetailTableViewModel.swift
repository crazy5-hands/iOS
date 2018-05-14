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
    
    init() {
        self.event = Event(id: "", author_id: "", title: "", body: "", created_at: NSDate())
        self.author = User(id: "", username: "", note: "", photo: "")
    }
    
    func getData(event: Event, complition: @escaping (Bool) -> Void){
        DispatchQueue.global(qos: .userInitiated).sync {
            self.event = event
            var joiners: [String] = []
            
            joiners = JoinUtil().getJoinerIdByEventId(eventId: event.id)
            
            for joinerId in joiners {
                if let user = UserUtil().getUser(id: joinerId) {
                    self.joiners.append(user)
                }
            }
            
            if event.author_id != "" {
                self.author = UserUtil().getUser(id: event.author_id)
                print(self.author?.username)
                complition(true)
            }else {
                complition(false)
            }
        }
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
}
