//
//  EventDetailTableViewModel.swift
//  hands
//
//  Created by 山浦功 on 2018/05/13.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import Foundation
import Firebase
import RxSwift

class EventDetailTableViewModel {
    
    private let disposeBag = DisposeBag()
    var event: Event?
    let joins: Observable<[Join]>
    let cost: Observable<Cost>
    var joinStatus: Observable<Bool> {
        return self.joins.map { (joins) -> Bool in
            var statusResult = false
            for join in joins {
                if join.user_id == self.uid! {
                    statusResult = true
                }
            }
            return statusResult
        }
    }
    let author: Observable<User>
    private let uid = Auth.auth().currentUser?.uid
    
    init(event: Event) {
        self.event = event
        let joinRouter = APIRouter.joins
        let costRouter = APIRouter.costs
        let authorRouter = APIRouter.users
        
        self.joins = Observable.create({ (observer) -> Disposable in
            var newJoins: [Join] = []
            joinRouter.collectionRef().whereField("event_id", isEqualTo: event.id).getDocuments(completion: { (snapshot, error) in
                if let snapshot = snapshot {
                    for document in snapshot.documents {
                        let join = Join(dictionary: document.data())
                        newJoins.append(join!)
                    }
                }
                observer.onNext(newJoins)
            })
            return Disposables.create()
        })
        self.cost = Observable.create({ (observer) -> Disposable in
            costRouter.collectionRef().whereField("event_id", isEqualTo: event.id).getDocuments { (snapshot, error) in
                if let snapshot = snapshot {
                    let newCost = Cost(dictionary: snapshot.documents[0].data())!
                    observer.onNext(newCost)
                }
            }
            return Disposables.create()
        })
        self.author = Observable.create({ (observer) -> Disposable in
            authorRouter.collectionRef().whereField("id", isEqualTo: event.author_id).getDocuments { (snapshot, error) in
                if let snapshot = snapshot {
                    let author = User(dictionary: snapshot.documents[0].data())
                    observer.onNext(author!)
                }
            }
            return Disposables.create()
        })
    }
}

extension EventDetailTableViewModel {
    
    //Eventとそれに付随する全てのデータの削除をする。
    private func delete() {
        if let event = self.event {
            let group = DispatchGroup()
            let eventRouter = APIRouter.events
            let joinRouter = APIRouter.joins
            let costRouter = APIRouter.costs
            
            //イベントの削除
            group.enter()
            eventRouter.collectionRef().document("").delete { (error) in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    group.leave()
                }
            }
            //Joinの削除
            joinRouter.collectionRef().whereField("event_id", isEqualTo: event.id).getDocuments { (snapshot, error) in
                if let snapshot = snapshot {
                    for document in snapshot.documents {
                        group.enter()
                        document.reference.delete(completion: { (error) in
                            if let error = error {
                                print(error.localizedDescription)
                            }
                            group.leave()
                        })
                    }
                }
            }
            //Costの削除
            costRouter.collectionRef().whereField("event_id", isEqualTo: event.id).getDocuments { (snapshot, error) in
                if let snapshot = snapshot {
                    for document in snapshot.documents {
                        group.enter()
                        document.reference.delete(completion: { (error) in
                            if let error = error {
                                print(error.localizedDescription)
                            }
                            group.leave()
                        })
                    }
                }
            }
        }
    }
}
