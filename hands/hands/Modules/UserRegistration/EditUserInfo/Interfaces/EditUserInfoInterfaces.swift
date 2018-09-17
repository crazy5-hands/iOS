//
//  EditUserInfoInterfaces.swift
//  hands
//
//  Created by 山浦功 on 2018/09/10.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import Foundation
import UIKit

protocol EditUSerInfoViewInterface: ViewInterface {
}

protocol EditUSerInfoWireframeInterface: WireframeInterface {
    func configureModule() -> UIViewController
    func segueToMain()
}

protocol EditUserInfoPresenterInterface: PresenterInterface {
    func updateUser(displyName: String, note: String)
    func setUser()
}

protocol EditUserInfoInteractorInterface: InteractorInterface {
    func getUser() -> User?
    func updateUser(displayName: String, note: String)
}
