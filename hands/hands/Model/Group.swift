//
//  Group.swift
//  hands
//
//  Created by 山浦功 on 2018/06/22.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import Foundation

struct Group {
    var id: String
    var createdAt: String
    var name: String
    var note: String
    var privated: Bool
    
    var dictionary: [String: Any] {
        return [
            "id": self.id,
            "created_at": self.createdAt,
            "name": self.name,
            "note": self.note,
            "privated": self.privated
        ]
    }
    
    init?(dictionary: [String: Any]) {
        self.id = dictionary["id"] as! String
        self.createdAt = dictionary["created_at"] as! String
        self.name = dictionary["name"] as! String
        self.note = dictionary["note"] as! String
        self.privated = dictionary["privated"] as! Bool
    }
}
