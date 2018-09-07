//
//  LoginPresenter.swift
//  hands
//
//  Created by 山浦功 on 2018/09/06.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import Foundation

/// Viewから受け取ったイベントを元に「画面の更新処理に関わるロジックの担当」
/// 🚫:禁止  import UIKit
/// Viewに対して画面更新の依頼
/// Interactorに対してデータの取得依頼を投げる
/// Routerに対して画面遷移の依頼
final class LoginPresenter: LoginPresenterInterface {

    private weak var view: LoginViewInterface?
    private let interactor: LoginInteractorInterface
    private let wireframe: LoginWireframeInterface
    
    init(view: LoginViewInterface, interactor: LoginInteractorInterface, wireframe: LoginWireframeInterface) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
    }
    
    // Interface
    func loginButtonTapped(email: String?, password: String?, login status: LoginStatus) {
        var result = RequestResult.failure(message: "ログインに失敗しました。")
        if let email = email, let password = password {
            switch status {
            case .signIn:
                self.interactor.signIn(email: email, password: password) { (signInResult) in
                    result = signInResult
                }
            case .signUp:
                self.interactor.signUp(email: email, password: password) { (signUpResult) in
                    result = signUpResult
                }
            default: break
            }
        }
        switch result {
        case .failure(let message):
            self.view?.showAlert(title: "エラー", message: message)
        default: break
        }
    }
    
    func savePassword(_ password: String?) {
        if let password = password {
            self.interactor.savePassword(password)
        } else {
            self.view?.showAlert(title: "エラー", message: "パスワードを入力してください。")
        }
    }
    
    func resetPassword(_ email: String?) {
        if let email = email {
            self.interactor.sendEmailToResetPassword(reset: email)
        } else {
            self.view?.showAlert(title: "エラー", message: "メールアドレスを入力して下さい。")
        }
    }
    
    // privates
    
    private func segueToPrivacyPolicy() {
    }
}

