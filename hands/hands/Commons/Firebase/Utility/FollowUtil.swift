//
//  FollowUtil.swift
//  hands
//
//  Created by 山浦功 on 2018/05/08.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import Foundation
import Firebase
import RxSwift

private enum FollowKey: String {
    case id = "id"
    case updateAt = "update_at"
    case userID = "user_id"
    case followID = "follow_id"

    var keyValue: String {
        return self.rawValue
    }
}

class FollowUtil {

    static let collectionRef = APIRouter.follows.collectionRef()

    static func update(target: Follow, comlition: @escaping (Bool) -> Void) {
        self.collectionRef.document(target.id).setData(target.dictionary) { (error) in
            if let error = error {
                print(error.localizedDescription)
                comlition(false)
            } else {
                comlition(true)
            }
        }
    }

    /// Followしている人たちの配列を返す
    /// 検証してません😭
    /// - Parameter userID: フォローする側のユーザーID
    /// - Returns: Followの配列
    static func getFollow(userID: String) -> Observable<[Follow]> {
        let key = FollowKey.userID.keyValue
        return Observable.create { observer in
            self.collectionRef.whereField(key, isEqualTo: userID).getDocuments(completion: { (snapshot, error) in
                if let snapshot = snapshot {
                    var follows: [Follow] = []
                    for document in snapshot.documents {
                        guard let new = Follow(dictionary: document.data()) else { return }
                        follows.append(new)
                    }
                    observer.onNext(follows)
                    observer.onCompleted()
                }
            })
            return Disposables.create()
        }
    }

    /// フォロワーの人たちの配列を返す
    /// 検証していません😭
    /// - Parameter followID: フォロワーのフォロー先のユーザーID
    /// - Returns: Followの配列
    static func getFollower(followID: String) -> Observable<[Follow]> {
        let key = FollowKey.followID.keyValue
        return Observable.create { observer in
            self.collectionRef.whereField(key, isEqualTo: followID).getDocuments(completion: { (snapshot, error) in
                if let snapshot = snapshot {
                    var follows: [Follow] = []
                    for document in snapshot.documents {
                        guard let new = Follow(dictionary: document.data()) else { return }
                        follows.append(new)
                    }
                    observer.onNext(follows)
                    observer.onCompleted()
                }
            })
            return Disposables.create()
        }
    }

    func getFollowers(follow_id: String, complition: @escaping ([Follow]) -> Void) {
        var followers: [Follow] = []
        let db = Firestore.firestore().collection("follows")
        db.whereField("follow_id", isEqualTo: follow_id).getDocuments { (snapshot, error) in
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    followers.append(Follow(dictionary: document.data())!)
                }
            }
            complition(followers)
        }
    }
    
    
    
    func getFollows(user_id: String, complition: @escaping ([Follow]) -> Void) {
        var follows: [Follow] = []
        let db = Firestore.firestore().collection("follows")
        db.whereField("user_id", isEqualTo: user_id).getDocuments { (snapshot, error) in
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    follows.append(Follow(dictionary: document.data())!)
                }
            }
            complition(follows)
        }
    }
    
    func delete(target: Follow, complition: @escaping (Bool) -> Void) {
        let db = Firestore.firestore()
        db.collection("follows").document(target.id).delete { (error) in
            if let error = error {
                print(error.localizedDescription)
                complition(false)
            } else {
                complition(true)
            }
        }
    }
}
