//
//  Join.swift
//  hands
//
//  Created by 山浦功 on 2018/05/03.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import Foundation

struct Join {
    
    var id: String
    var event_id: String
    var user_id: String
    var created_at: NSDate
    var dictionary: [String: Any] {
        return [
            "id": self.id,
            "event_id": self.event_id,
            "user_id": self.user_id,
            "create_at": self.created_at
        ]
    }
    
    init?(dictionary: [String: Any]){
        let id = dictionary["id"] as! String
        let event_id = dictionary["event_id"] as! String
        let user_id = dictionary["user_id"] as! String
        let created_at = dictionary["created_at"] as! NSDate
        self.init(id: id, event_id: event_id, user_id: user_id, created_at: created_at)
    }
    
    init(id: String, event_id: String, user_id: String, created_at: NSDate) {
        self.id = id
        self.event_id = event_id
        self.user_id = user_id
        self.created_at = created_at
    }
}
