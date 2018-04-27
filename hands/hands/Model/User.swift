//
//  User.swift
//  hands
//
//  Created by 山浦功 on 2018/04/28.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import Foundation
import Firebase

class User: NSObject {
    
    var uid: String
    var username: String
    var photoURL: String
    var note: String
    var owner: String
    var join: Dictionary<String, Bool>?
    
    init(uid: String, username: String, photoURL: String, note: String, owner: String) {
        self.uid = uid
        self.username = username
        self.photoURL = photoURL
        self.note = note
        self.owner = owner
    }
    
    init?(snapchat: DataSnapshot){
        guard let dict = snapchat.value as? [String: Any] else { return nil }
        guard let uid = dict["uid"] as? String else { return nil }
        guard let username = dict["username"] as? String else { return nil }
        guard let photoURL = dict["photoURL"] as? String else { return nil }
        guard let note = dict["note"] as? String else { return nil }
        guard let owner = dict["owner"] as? String else { return nil }
        
        self.uid = uid
        self.username = username
        self.photoURL = photoURL
        self.note = note
        self.owner = owner
    }
    
    convenience override init() {
        self.init(uid: "", username: "", photoURL: "", note: "", owner: "")
    }
}
