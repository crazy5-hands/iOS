//
//  Event.swift
//  hands
//
//  Created by 山浦功 on 2018/04/28.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import Foundation


struct Event {
    
    var id: String
    var author_id: String
    var title: String
    var body: String
    var create_at: NSDate
    var dictionary: [String: Any] {
        return [
            "id": self.id,
            "author_id": self.author_id,
            "title": self.title,
            "body": self.body,
            "create_at": self.create_at
        ]
    }
    
    init?(dictionary: [String: Any]) {
        let id = dictionary["id"] as! String
        let author_id = dictionary["author_id"] as! String
        let title = dictionary["title"] as! String
        let body = dictionary["body"] as! String
        let create_at = dictionary["create_at"] as! NSDate
        
        self.init(id: id, author_id: author_id, title: title, body: body, create_at: create_at)
    }
    
    init(id: String, author_id: String, title: String, body: String, create_at: NSDate) {
        self.id = id
        self.author_id = author_id
        self.title = title
        self.body = body
        self.create_at = create_at
    }
}
