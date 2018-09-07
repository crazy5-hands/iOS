//
//  LoginViewController.swift
//  hands
//
//  Created by 山浦功 on 2018/04/10.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: TextFieldViewController {

    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var changeStatusSegmentedControl: UISegmentedControl!
    
    private var handle: AuthStateDidChangeListenerHandle?
    var presenter: LoginPresenterInterface?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //delegate of TextField
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        self.emailTextField.keyboardType = .emailAddress
        self.passwordTextField.isSecureTextEntry = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        handle = Auth.auth().addStateDidChangeListener({ (auth, user) in
            })
        self.setUpNotificationForTextField()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    @IBAction func submit(_ sender: Any) {
        //show processing
        let processingView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        processingView.center = self.view.center
        self.view.addSubview(processingView)
        processingView.startAnimating()
        
        var status: LoginStatus
        switch self.changeStatusSegmentedControl.selectedSegmentIndex {
        case 0:
            status = .signIn
        case 1:
            status = .signUp
        default:
            break
        }
        self.presenter?.loginButtonTapped(email: self.emailTextField.text,
                                          password: self.passwordTextField.text,
                                          login: status)
    }
    
    @IBAction func sendPasswordResetWithEmail(_ sender: Any) {
        self.presenter?.resetPassword(self.emailTextField.text)
    }
}

extension LoginViewController: LoginViewInterface {
    func showAlert(title: String, message: String) {
        self.showAlert(title: title, message: message)
    }
}

extension LoginViewController: StoryboardLoadable {
    static var storyboardName: String {
        return Storyboard.loginViewController.name
    }
}
