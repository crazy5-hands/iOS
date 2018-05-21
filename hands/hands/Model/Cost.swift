//
//  Cost.swift
//  hands
//
//  Created by 山浦功 on 2018/05/21.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import Foundation

struct Cost {
    
    var id: String
    var created_at: NSDate
    var event_id: String
    var cost: Int
    var dictionary: [String: Any] {
        return [
            "id": self.id,
            "created_at": self.created_at,
            "event_id": self.event_id,
            "cost": self.cost,
        ]
    }
    
    init?(dictionary: [String: Any]) {
        let id = dictionary["id"] as! String
        let created_at = dictionary["created_at"] as! NSDate
        let event_id = dictionary["title"] as! String
        let cost = dictionary["body"] as! Int
        
        self.init(id: id, created_at: created_at, event_id: event_id, cost: cost)
    }
    
    init(id: String, created_at: NSDate, event_id: String, cost: Int) {
        self.id = id
        self.created_at = created_at
        self.event_id = event_id
        self.cost = cost
    }
}
