//
//  SplashWireframeInterface.swift
//  hands
//
//  Created by 山浦功 on 2018/08/21.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import UIKit

protocol SplashWireframeInterface: WireframeInterface {
    func configureModule() -> UIViewController
    func showLoginScreenAsRoot()
    func showMainScreenAsRoot()
}

protocol SplashViewInterface: ViewInterface {
}

protocol SplashPresenterInterface: PresenterInterface {
    func viewDidload()
}
