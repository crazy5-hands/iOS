//
//  NewEventViewModel.swift
//  hands
//
//  Created by 山浦功 on 2018/05/04.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import Foundation
import Firebase

class NewEventViewModel {
    
    private var uid: String
    private let db = Firestore.firestore()
    
    init() {
        uid = (Auth.auth().currentUser?.uid)!
    }
    
    
    func createNewEvent(id: String, title: String, body: String, callback: @escaping (Bool) -> Void) {
        let event = Event(id: id, author_id: self.uid, title: title, body: body, created_at: NSDate())
        EventUtil().updateEvent(target: event) { (result) in
            callback(result)
        }
    }
}
