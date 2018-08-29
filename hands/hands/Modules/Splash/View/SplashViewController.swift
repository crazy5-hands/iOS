//
//  SplashViewController.swift
//  hands
//
//  Created by 山浦功 on 2018/08/30.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import UIKit

final class SplashViewController: UIViewController {
    
    var presenter: SplashPresenterInterface!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidload()
    }
}

extension SplashViewController: SplashViewInterface, StoryboardLoadable {
    
    static var storyboardName: String {
        return Storyboard.splashViewController.name
    }
}
