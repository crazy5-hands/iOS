//
//  FirebaseInterface.swift
//  hands
//
//  Created by 山浦功 on 2018/09/06.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import Foundation

/// Control Firebase
protocol FirebaseUtilityInterface {
}

protocol PhotoUtilityInterface: FirebaseUtilityInterface {}
protocol UserUtilityInterface: FirebaseUtilityInterface {
    static func getUser(user id: String, completion: @escaping (User?) -> Void)
    static func delete(user: User)
}
protocol FollowUtilityInterface: FirebaseUtilityInterface {
    func update(target: Follow, complition: @escaping (Bool) -> Void)
    func getFollowers(follow_id: String, complition: @escaping ([Follow]) -> Void)

}
protocol JoinUtilityInterface: FirebaseUtilityInterface {}
protocol CostUtilityInterface: FirebaseUtilityInterface {}
protocol PayUtilityInterface: FirebaseUtilityInterface {}
protocol AppUtilityInterface: FirebaseUtilityInterface {}


