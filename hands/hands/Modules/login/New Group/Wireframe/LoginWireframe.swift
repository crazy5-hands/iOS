//
//  LoginWireframe.swift
//  hands
//
//  Created by 山浦功 on 2018/09/02.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import UIKit

// 画面遷移　依存関係を担当
final class LoginWireframe: LoginWireframeInterface {

    weak var viewController: CustomNavigationController!
    private let navigationController: UINavigationController!
    var complition: ((User?) -> Void)?
    
    init(navigation: UINavigationController) {
        self.navigationController = navigation
    }
    
    func goToNextStep(_ output: User?) {
        self.complition?(output)
    }
    
    func back() {
        self.complition?(nil)
    }
    
    func configureModule() -> UIViewController {
        let viewcontroller = LoginViewController.fromStoryboard()
        let interactor = LoginInteractor()
        let presenter = LoginPresenter(view: viewcontroller, interactor: interactor, wireframe: self)
        viewcontroller.presenter = presenter
        return viewcontroller
    }
    
    func showPrivatePoilicyScreenAsRoot() {}
    
    func showEditUserInfoScreenAsRoot() {}
}

