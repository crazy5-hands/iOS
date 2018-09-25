//
//  EventUtil.swift
//  hands
//
//  Created by 山浦功 on 2018/05/08.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//
import Firebase
import RxSwift

private enum EventKey: String {
    case id = "id"
    case authorID = "author_id"

    var stringValue: String {
        return self.rawValue
    }
}

class EventUtil {
    
    //APIの種類を設定
    static private let collectionRef = APIRouter.events.collectionRef()

    /// 自分が保有するイベントの配列を返す
    /// 検証していません😭
    /// - Parameter authorID: イベントを作った人のID(この場合自分)
    /// - Returns: イベントの配列
    static func getOwnEvent(authorID: String) -> Observable<[Event]>{
        let key = EventKey.authorID.stringValue
        return Observable.create({ observer in
            self.collectionRef.whereField(key, isEqualTo: authorID).getDocuments { (snapshot, error) in
                if let snapshot = snapshot {
                    var events: [Event] = []
                    for document in snapshot.documents {
                        guard let new = Event(dictionary: document.data()) else { return }
                        events.append(new)
                    }
                    observer.onNext(events)
                }
                observer.onCompleted()
            }
            return Disposables.create()
        })
    }

    /// EventIDでイベント情報の取得
    /// 検証していません😭
    /// - Parameter eventID: eventID
    /// - Returns: EventをOptionalで返す
    static func getEvent(with eventID: String) -> Observable<Event?> {
        let key = EventKey.id.stringValue
        return Observable.create({ observer in
            self.collectionRef.whereField(key, isEqualTo: eventID).getDocuments { (snapshot, error) in
                var event: Event?
                if let snapshot = snapshot {
                    guard let document = snapshot.documents.first else { return }
                    guard let new = Event(dictionary: document.data()) else { return }
                    event = new
                }
                observer.onNext(event)
                observer.onCompleted()
            }
            return Disposables.create()
        })
    }

    /// 全てのEventの取得をする
    /// 検証していません😭
    /// - Returns: eventの配列
    static func getAll() -> Observable<[Event]> {
        return Observable.create({ observer in
            self.collectionRef.getDocuments(completion: { (snapshot, error) in
                if let snapshot = snapshot {
                    var events: [Event] = []
                    for document in snapshot.documents {
                        guard let new = Event(dictionary: document.data()) else { return }
                        events.append(new)
                    }
                    observer.onNext(events)
                }
                observer.onCompleted()
            })
            return Disposables.create()
        })
    }

    /// ⚠️注意
    /// getOwnEvent()に変更になる。
    static func getOwnEvents(authorId: String, complition: @escaping ([Event]) -> Void) {
        self.collectionRef.whereField("author_id", isEqualTo: authorId).getDocuments { (snapshot, error) in
            var events: [Event] = []
            if let snapshot = snapshot {
                if snapshot.documents.isEmpty != true {
                    for document in snapshot.documents {
                        events.append(Event(dictionary: document.data())!)
                    }
                }
                complition(events)
            }else {
                print(error!.localizedDescription)
                complition(events)
            }
        }
    }


    
    /// ⚠️注意
    /// いずれ getEvent(with eventID: String)に変える
    static func getEventByEventId(eventId: String, complition: @escaping (Event?) -> Void) {
        self.collectionRef.whereField("id", isEqualTo: eventId).getDocuments { (snapshot, error) in
            var event: Event? = nil
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    event = Event(dictionary: document.data())!
                }
            }
            complition(event)
        }
    }

    /// ⚠️注意
    /// いずれgetAll()に変更
    static func getEventsAll(complition: @escaping ([Event]) -> Void) {
        self.collectionRef.getDocuments { (snapshot, error) in
            var events: [Event] = []
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    events.append(Event(dictionary: document.data())!)
                }
            }
            complition(events)
        }
    }
    
    static func updateEvent(target: Event, complition: @escaping (Bool) -> Void) {
        self.collectionRef.document(target.id).setData(target.dictionary) { (error) in
            if let error = error {
                print(error.localizedDescription)
                complition(false)
            }else {
                complition(true)
            }
        }
    }
    
    static func delete(target: Event, complition: @escaping (Bool) -> Void) {
        self.collectionRef.document(target.id).delete { (error) in
            if error != nil {
                complition(false)
            } else {
                complition(true)
            }
        }
    }
 }
