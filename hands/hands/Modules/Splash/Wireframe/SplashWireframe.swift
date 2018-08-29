//
//  SplashWireframe.swift
//  hands
//
//  Created by 山浦功 on 2018/08/21.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import UIKit

final class SplashWireframe: SplashWireframeInterface {
    
    weak var viewController: SplashViewController!
    
    func configureModule() -> UIViewController {
        let viewController = SplashViewController.fromStoryboard()
        let interactor = SplashIntefractor
        let presenter =
        self.viewController = viewController
        return viewController
    }
    
    func showMainScreenAsRoot() {
        let root = AppDelegate.shared.rootViewController
        root.showMainScreen()
    }
    
    func showLoginScreenAsRoot() {
        let root = AppDelegate.shared.rootViewController
        root.showLoginScreen()
    }

}
