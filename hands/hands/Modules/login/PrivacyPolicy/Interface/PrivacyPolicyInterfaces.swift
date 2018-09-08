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
    func showEditUserInfo()
}

protocol PrivacyPolicyViewInterface: ViewInterface {
}

protocol PrivacyPolicyPresenterInterface: PresenterInterface {
    func showNextView(agree: Bool)
}

protocol PrivacyPolicyInteractorInterface: InteractorInterface {
    func getAgreement() -> Bool
    func saveAgreement(_ value: Bool)
}
