//
//  EditUserInfoWireframe.swift
//  hands
//
//  Created by 山浦功 on 2018/09/17.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import Foundation
import UIKit

final class EditUserInfoWireframe: EditUserInfoWireframeInterface {

    func configureModule() -> UIViewController {
        let target = EditUserInfoViewController.fromStoryboard()
        return target
    }

    func segueToMain() {
        let main = MainTabBarController()
        AppDelegate.shared.rootViewController.present(main, animated: true, completion: nil)
    }
}
