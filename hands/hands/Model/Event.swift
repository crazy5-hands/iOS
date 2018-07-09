//
//  Event.swift
//  hands
//
//  Created by 山浦功 on 2018/04/28.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import Foundation


struct Event: Codable {
    
    var id: String
    var author_id: String
    var title: String
    var body: String
    var created_at: NSDate
    var dictionary: [String: Any] {
        return [
            "id": self.id,
            "author_id": self.author_id,
            "title": self.title,
            "body": self.body,
            "created_at": self.created_at
        ]
    }
    init(from decoder: Decoder) throws {
        
    }
    
    init?(dictionary: [String: Any]) {
        let id = dictionary["id"] as! String
        let author_id = dictionary["author_id"] as! String
        let title = dictionary["title"] as! String
        let body = dictionary["body"] as! String
        let created_at = dictionary["created_at"] as! NSDate
        
        self.init(id: id, author_id: author_id, title: title, body: body, created_at: created_at)
    }
    
    init(id: String, author_id: String, title: String, body: String, created_at: NSDate) {
        self.id = id
        self.author_id = author_id
        self.title = title
        self.body = body
        self.created_at = created_at
    }
}
