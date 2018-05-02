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
    var own: [String]
    var join: [String]
    var follow: [String]
    var follower: [String]
    
    var dictionary: [String: Any] {
        return [
            "id": self.id,
            "username": self.username,
            "note": self.note,
            "photo": self.photo,
            "own": self.own,
            "join": self.join,
            "follow": self.follow,
            "follower": self.follower
        ]
    }
    
    init?(dictionary: [String: Any]) {
        let id = dictionary["id"] as! String
        let username = dictionary["username"] as! String
        let note = dictionary["note"] as! String
        let photo = dictionary["photo"] as! String
        let own = dictionary["own"] as! [String]
        let join = dictionary["join"] as! [String]
        let follow = dictionary["follow"] as! [String]
        let follower = dictionary["follower"] as! [String]
        print("id")
        print(id)
        
        self.init(id: id, username: username, note: note, photo: photo, own: own, join: join, follow: follow, follower: follower)
        print(self.id)
    }
    
    init(id: String, username: String, note: String, photo: String, own: [String], join: [String], follow: [String], follower: [String]) {
        self.id = id
        self.username = username
        self.note = note
        self.photo = photo
        self.own = own
        self.join = join
        self.follow = follow
        self.follower = follower
    }
    
    init(){
        self.init(id: "", username: "", note: "", photo: "", own: [""], join: [""], follow: [""], follower: [""])
    }
}

//class User: NSObject {
//
//    var uid: String
//    var username: String
//    var photoURL: String
//    var note: String
//    var owner: String
//    var join: Dictionary<String, Bool>?
//
//    init(uid: String, username: String, photoURL: String, note: String, owner: String) {
//        self.uid = uid
//        self.username = username
//        self.photoURL = photoURL
//        self.note = note
//        self.owner = owner
//    }
//
//    init?(snapchat: DataSnapshot){
//        guard let dict = snapchat.value as? [String: Any] else { return nil }
//        guard let uid = dict["uid"] as? String else { return nil }
//        guard let username = dict["username"] as? String else { return nil }
//        guard let photoURL = dict["photoURL"] as? String else { return nil }
//        guard let note = dict["note"] as? String else { return nil }
//        guard let owner = dict["owner"] as? String else { return nil }
//
//        self.uid = uid
//        self.username = username
//        self.photoURL = photoURL
//        self.note = note
//        self.owner = owner
//    }
//
//    convenience override init() {
//        self.init(uid: "", username: "", photoURL: "", note: "", owner: "")
//    }
//}
