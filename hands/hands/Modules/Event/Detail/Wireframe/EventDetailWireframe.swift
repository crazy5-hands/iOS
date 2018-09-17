//
//  EventDetailWireframe.swift
//  hands
//
//  Created by 山浦功 on 2018/09/17.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import Foundation
import UIKit

final class EventDetailWireframe: EventDetailWireframeInterface {

    func configureModule(event: Event) -> UIViewController {
        let viewController = EventDetailTableViewController.fromStoryboard()
        let interactor = EventDetailInteractor()
        let presenter = EventDetailPresenter(view: viewController, interactor: interactor, wireframe: self)
        viewController.presenter = presenter
        return viewController
    }
}
