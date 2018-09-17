//
//  EditUserInfoPresenter.swift
//  hands
//
//  Created by 山浦功 on 2018/09/17.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import Foundation
import RxCocoa

final class EditUserInfoPresenter: EditUserInfoPresenterInterface {

    private var view: EditUserInfoViewInterface?
    private var wireframe: EditUserInfoWireframeInterface?
    private var interactor: EditUserInfoInteractorInterface?
    var user: User?
    var canSubmit: Driver<Bool> = Driver.empty()

    init(view: EditUserInfoViewInterface, wireframe: EditUserInfoWireframeInterface, interactor: EditUserInfoInteractorInterface) {
        self.view = view
        self.wireframe = wireframe
        self.interactor = interactor
    }

    func bind(input: Input) {
    }

    func updateUser(displyName: String, note: String) {
        <#code#>
    }

    func setUser() {
        self.user = self.interactor?.getUser()
    }
}
