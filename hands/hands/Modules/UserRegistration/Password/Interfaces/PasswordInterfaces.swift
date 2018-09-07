//
//  PasswordInterfaces.swift
//  hands
//
//  Created by 山浦功 on 2018/09/03.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import UIKit

protocol PasswordWireframeInterface: WireframeInterface {
    func configureModule() -> UIViewController
    func goToNextStep()
    func back()
}
