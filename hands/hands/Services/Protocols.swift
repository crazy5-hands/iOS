//
//  Protocols.swift
//  hands
//
//  Created by 山浦功 on 2018/08/18.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import RxCocoa
import RxSwift

enum EventType {
    case own
    case follow(id: String)
    case follower(id: String)
    case join(id: String)
}

protocol EventService {
    func getEvents(_ eventType: [EventType]) -> Observable<[Event]>
    func getEventDetail(_ eventType: EventType) -> Observable<Event>
}
