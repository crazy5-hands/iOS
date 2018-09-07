//
//  LoginInterfaces.swift
//  hands
//
//  Created by 山浦功 on 2018/09/02.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import UIKit

enum LoginStatus: Int {
    case signIn
    case signUp
    case signOut
}

/// Router 「画面遷移」と「依存関係」の担当
protocol LoginWireframeInterface: WireframeInterface {
    func goToNextStep(_ output: User?)
    func back()
    func configureModule() -> UIViewController
    func showPrivatePoilicyScreenAsRoot()
    func showEditUserInfoScreenAsRoot()
}


/// 画面の更新、Presenterへの通知の担当
protocol LoginViewInterface: ViewInterface {
    func showAlert(title: String, message: String)
}

protocol LoginPresenterInterface: PresenterInterface {
    func loginButtonTapped(email: String?, password: String?, login status: LoginStatus)
    func savePassword(_ password: String?)
    func resetPassword(_ email: String?)
}

/// データに関わるロジックの担当 Presenterから依頼されたデータを返す
protocol LoginInteractorInterface: InteractorInterface {
    func signIn(email: String, password: String, complition: @escaping ((RequestResult) -> Void))
    func signUp(email: String, password: String, complition: @escaping ((RequestResult) -> Void))
    func savePassword(_ password: String)
    func sendEmailToResetPassword(reset email: String)
}
