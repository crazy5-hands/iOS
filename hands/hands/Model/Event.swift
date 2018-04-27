//
//  Event.swift
//  hands
//
//  Created by 山浦功 on 2018/04/28.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class Event: NSObject {
    var eventId: String
    var uid: String
    var author: String
    var title: String
    var body: String
    var create_at: String
    var joinerCount: NSObject?
    
    init(eventId: String, uid: String, author: String, title: String, body: String, create_at: String) {
        self.eventId = eventId
        self.uid = uid
        self.author = author
        self.title = title
        self.body = body
        self.create_at = create_at
    }
    
    init?(snapchat: DataSnapshot) {
        guard let dict = snapchat.value as? [String: Any] else { return nil }
        guard let eventId = dict["eventId"] as? String else { return nil }
        guard let uid = dict["uid"] as? String else { return nil }
        guard let author = dict["author"] as? String else { return nil }
        guard let title = dict["title"] as? String else { return nil }
        guard let body = dict["body"] as? String else { return nil }
        guard let create_at = dict["create_at"] as? String else { return nil }
        
        self.eventId = eventId
        self.uid = uid
        self.author = author
        self.title = title
        self.body = body
        self.create_at = create_at
     }
    
    convenience override init() {
        self.init(eventId: "", uid: "", author: "", title: "", body: "", create_at: "")
    }
}
