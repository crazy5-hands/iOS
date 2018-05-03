//
//  EventListTableViewModel.swift
//  hands
//
//  Created by 山浦功 on 2018/05/04.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import Foundation
import Firebase

class EventListTableViewModel {
    
    var events: [Event] = []
    private let uid = Auth.auth().currentUser?.uid
    private let db = Firestore.firestore()
    private var eventRef: CollectionReference?
    private var followRef: CollectionReference?
    
    init() {
        self.eventRef = db.collection("events")
        self.followRef = db.collection("follows")
    }
    
    func getOwnEvent() {
        
    }
    
    func getfollowsEvent() {
        
    }
    
    func orderByCreatedAt() {
        
    }
}
