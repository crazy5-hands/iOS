//
//  Follow.swift
//  hands
//
//  Created by 山浦功 on 2018/05/03.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import Foundation

struct Follow {
    
    let id: String
    var update_at: NSDate
    var user_id: String
    var follow_id: String
    var dictionary: [String: Any]{
        return [
            "id": self.id,
            "update_at": self.update_at,
            "user_id": self.user_id,
            "follow_id": self.follow_id
        ]
    }
    
    init?(dictionary: [String: Any]) {
        let id = dictionary["id"] as! String
        let update_at = dictionary["update_at"] as! NSDate
        let user_id = dictionary["user_id"] as! String
        let follow_id = dictionary["follow_id"] as! String
        
        self.init(id: id, update_at: update_at, user_id: user_id, follow_id: follow_id)
    }
    
    init(id: String, update_at: NSDate, user_id: String, follow_id: String) {
        self.id = id
        self.update_at = update_at
        self.user_id = user_id
        self.follow_id = follow_id
    }
}
