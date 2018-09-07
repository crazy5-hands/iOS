//
//  PrivacyPolicyInterfaces.swift
//  hands
//
//  Created by 山浦功 on 2018/09/02.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import UIKit

protocol PrivacyPolicyWireframeInterface: WireframeInterface {
    func configureModule() -> UIViewController
    func showMainScreenAsRoot()
}


