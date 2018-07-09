//
//  APIRouter.swift
//  hands
//
//  Created by 山浦功 on 2018/07/09.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import Foundation
import Firebase

enum APIRouter {
    case costs
    case events
    case follows
    case joins
    case users
    
    
    /// collectionの先をString型で返す。
    private var collection: String {
        switch self {
        case .costs:
            return "costs"
        case .events:
            return "events"
        case .follows:
            return "follows"
        case .joins:
            return "joins"
        case .users:
            return "users"
        }
    }
    
    /// collectionを返す。
    ///
    /// - Returns: collectionReferenceを返す
    func collectionRef() -> CollectionReference {
        let firestore = Firestore.firestore()
        return firestore.collection(self.collection)
    }
}
