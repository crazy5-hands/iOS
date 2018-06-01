//
//  Pay.swift
//  hands
//
//  Created by 山浦功 on 2018/05/22.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import Foundation

struct Pay {
    
    var id: String
    var created_at: NSDate
    var event_id: String
    var user_id: String
    var paid: Bool
    var dictionary: [String: Any] {
        return [
            "id": self.id,
            "created_at": self.created_at,
            "event_id": self.event_id,
            "user_id": self.user_id,
            "paid": self.paid
        ]
    }
    
    init?(dictionary: [String: Any]) {
        let id = dictionary["id"] as! String
        let created_at = dictionary["created_at"] as! NSDate
        let event_id = dictionary["title"] as! String
        let user_id = dictionary["user_id"] as! String
        let paid = dictionary["paid"] as! Bool
        
        self.init(id: id, created_at: created_at, event_id: event_id, user_id: user_id, paid: paid)
    }
    
    init(id: String, created_at: NSDate, event_id: String, user_id: String, paid: Bool) {
        self.id = id
        self.created_at = created_at
        self.event_id = event_id
        self.user_id = user_id
        self.paid = paid
    }
    
    init() {
        self.init(id: "", created_at: NSDate(), event_id: "", user_id: "", paid: false)
    }
}
