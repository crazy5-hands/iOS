//
//  Member.swift
//  hands
//
//  Created by 山浦功 on 2018/06/22.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import Foundation

struct Member {
    
    var id: String
    var belongTo: String
    var createdAt: NSDate
    var userId: String
    
    var dictiory: [String: Any] {
        get {
            return [
                "id": self.id,
                "belong_to": self.belongTo,
                "created_at": self.createdAt,
                "user_id": self.userId
            ]
        }
    }
    
    init?(dictionary: [String: Any]) {
        self.id = dictionary["id"] as! String
        self.belongTo = dictionary["belong_to"] as! String
        self.createdAt = dictionary["created_at"] as! NSDate
        self.userId = dictionary["user_id"] as! String
    }
}
