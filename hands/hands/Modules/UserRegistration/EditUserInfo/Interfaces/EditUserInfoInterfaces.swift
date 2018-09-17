//
//  EditUserInfoInterfaces.swift
//  hands
//
//  Created by 山浦功 on 2018/09/10.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol EditUserInfoViewInterface: ViewInterface {
    func showLoading()
}

protocol EditUserInfoWireframeInterface: WireframeInterface {
    func configureModule() -> UIViewController
    func segueToMain()
}

protocol EditUserInfoPresenterInterface: PresenterInterface {
    typealias Input = (
        displayName: Driver<String>,
        note: Driver<String>
    )
    var canSubmit: Driver<Bool> { get }
    func bind(input: Input)
    func updateUser(displyName: String, note: String)
    func setUser()
}

protocol EditUserInfoInteractorInterface: InteractorInterface {
    func getUser() -> User?
    func updateUser(displayName: String, note: String)
}
