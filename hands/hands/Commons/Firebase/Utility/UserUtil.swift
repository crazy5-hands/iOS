//
//  UserUtil.swift
//  hands
//
//  Created by 山浦功 on 2018/05/07.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import Foundation
import Firebase
import RxSwift

private enum UserKey: String {
    case id = "id"
    case username = "username"
    case note = "note"
    case photo = "photo"

    var name: String {
        return self.rawValue
    }
}

public class UserUtil: UserUtilityInterface {

    static private let collectionRef = Firestore.firestore().collection("users")

    /// UserIDを渡す事でUserを取得できるはず！
    /// まだ検証していません😭
    /// - Parameter id: UserID
    /// - Returns: ObservableなUser
    static func getUser(user id: String) -> Observable<User> {
        return Observable.create({ observer in
            let keyID = UserKey.id.name
            self.collectionRef.whereField(keyID, isEqualTo: id).getDocuments(completion: { (snapshot, error) in
                guard let snapshot = snapshot else {
                    observer.onError(error!)
                    return
                }
                guard let new = User(dictionary: (snapshot.documents.first?.data())!) else { return }
                observer.onNext(new)
                observer.onCompleted()
            })
            return Disposables.create()
        })
    }

    /// すべてのUserを取得
    /// まだ検証していません😭
    /// - Returns: ObservableなUserの配列を返す
    static func getUserAll() -> Observable<[User]> {
        return Observable.create({ (observer) -> Disposable in
            self.collectionRef.getDocuments(completion: { (snapshot, error) in
                guard let snapshot = snapshot else {
                    observer.onError(error!)
                    return
                }
                var users: [User] = []
                for document in snapshot.documents {
                    if let user = User(dictionary: document.data()) {
                        users.append(user)
                    }
                }
                observer.onNext(users)
                observer.onCompleted()
            })
            return Disposables.create()
        })
    }

    static func getUser(user id: String, completion: @escaping (User?) -> Void) {
        let keyID = UserKey.id.name
        self.collectionRef.whereField(keyID, isEqualTo: id).getDocuments { (snapshot, error) in
            if let snapshot = snapshot {
                if snapshot.documents.isEmpty == true {
                    completion(nil)
                } else {
                    completion(User(dictionary: snapshot.documents[0].data()))
                }
            }else {
                print(error!.localizedDescription)
                completion(nil)
            }
        }
    }

    static func delete() {
    }
    /// すべてのユーザーを返す
    ///
    /// - Returns: ただし、データが一つしかない場合は取得に失敗している
    static func getAllUsers(complition: ([User]) -> Void) {
        var users: [User] = []
        let semaphore = DispatchSemaphore(value: 0)
        self.collectionRef.getDocuments { (snapshot, error) in
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    users.append(User(dictionary: document.data())!)
                }
            }else {
                print(error!.localizedDescription)
            }
            semaphore.signal()
        }
        semaphore.wait()
        complition(users)
    }
    
    static func putUser(id: String, user: User, complition: ((Bool) -> Void)?) {
        let collectionRef = Firestore.firestore().collection("users")
        collectionRef.document(id).setData(user.dictionary) { (error) in
            if error != nil {
                complition!(false)
            }else {
                complition!(true)
            }
        }
    }
}
