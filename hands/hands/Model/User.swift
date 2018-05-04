//
//  User.swift
//  hands
//
//  Created by 山浦功 on 2018/04/28.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import Foundation


struct User {
    
    var id: String
    var username: String
    var note: String
    var photo: String
    
    var dictionary: [String: Any] {
        return [
            "id": self.id,
            "username": self.username,
            "note": self.note,
            "photo": self.photo
        ]
    }
    
    init?(dictionary: [String: Any]) {
        let id = dictionary["id"] as! String
        let username = dictionary["username"] as! String
        let note = dictionary["note"] as! String
        let photo = dictionary["photo"] as! String
        
        self.init(id: id, username: username, note: note, photo: photo)
    }
    
    init(id: String, username: String, note: String, photo: String) {
        self.id = id
        self.username = username
        self.note = note
        self.photo = photo
    }
    
    init(){
        self.init(id: "", username: "", note: "", photo: "")
    }
}
