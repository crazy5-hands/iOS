//
//  EventDetailInteracot.swift
//  hands
//
//  Created by 山浦功 on 2018/09/17.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import RxSwift
import Firebase

final class EventDetailInteractor: EventDetailInteractorInterface {

    private var event: Event
    var presenter: EventDetailPresenterInterface?

    init(event: Event) {
        self.event = event
    }


    func getUser(event: User, dataType: APIRouter) -> Observable<Event> {
        return Observable.create({ (observer) in
            EventUtil.getEventById(id: event.id, complition: { (event) in
                if let event = event {
                    observer.onNext(event)
                }
                observer.onCompleted()
            })
            return Disposables.create()
        })
    }

    func getJoin() -> Observable<Join> {
        return Observable.create({ (observer) in
            return Disposables.create()
        })
    }
}
