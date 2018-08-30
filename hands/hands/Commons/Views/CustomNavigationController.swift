//
//  CustomNavigationController.swift
//  hands
//
//  Created by 山浦功 on 2018/08/30.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import UIKit

final class CustomNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
}

extension CustomNavigationController {
    @objc func logout(_: UIBarButtonItem) {
        print("ログアウトが押されたよ")
//        let root = AppDelegate.shared.rootViewController
//        root.logout()
    }
}

extension CustomNavigationController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        self.setupButton()
    }
    
    private func setupButton() {
        let button = UIBarButtonItem(title: "ログアウト", style: .plain, target: self, action: #selector(logout(_:)))
        self.navigationBar.topItem?.rightBarButtonItem = button
    }
}
