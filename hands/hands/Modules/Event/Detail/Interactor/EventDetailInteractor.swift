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

    private var event: Event?

    init(event: Event) {
        self.event = event
    }

    func getData<T>(data: T, dataType: APIRouter) -> Observable<T> {
        return Observable.create({ (observer) in
            if let event = self.event {
                EventUtil.getEventById(id: event.id, complition: { (event) in
                    
                })
            }
        })
    }
}
