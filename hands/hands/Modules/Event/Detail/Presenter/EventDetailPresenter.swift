//
//  EventDetailPresenter.swift
//  hands
//
//  Created by 山浦功 on 2018/09/17.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import Foundation

final class EventDetailPresenter: EventDetailPresenterInterface {

    private let view: EventDetailViewInterface?
    private let interactor: EventDetailInteractorInterface?
    private let wireframe: EventDetailWireframeInterface?

    init(view: EventDetailViewInterface, interactor: EventDetailInteractorInterface, wireframe: EventDetailWireframeInterface) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
    }
}
