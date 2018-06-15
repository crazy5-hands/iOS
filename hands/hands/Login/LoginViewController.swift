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
    
    @IBAction func submit(_ sender: Any) {
        //show processing
        let processingView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        processingView.center = self.view.center
        self.view.addSubview(processingView)
        processingView.startAnimating()
        guard let email = self.emailTextField.text else { return }
        guard let password = self.passwordTextField.text else { return }

        if self.changeStatusSegmentedControl.selectedSegmentIndex == 0 {
            Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                //remove processing
                processingView.stopAnimating()
                self.view.willRemoveSubview(processingView)
                
                if let error = error {
                    print(error.localizedDescription)
                    switch error.localizedDescription {
                    case "The password is invalid or the user does not have a password.":
                        self.showAlert("パスワードが違います。もう一度確認してください。")
                    case "The email address is badly formatted.":
                        self.showAlert("メールアドレスの形式が違います。")
                    default:
                        self.showAlert("メールアドレスかパスワードが違います。")
                    }
                }else {
                    self.savePassword(password)
                    self.segueToPrivacyPolicy()
                }
            }
        }else {
            //create new user
            Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                //remove processing
                processingView.stopAnimating()
                self.view.willRemoveSubview(processingView)
                if let error = error {
                    if error.localizedDescription == "The email address is already in use by another account." {
                        self.showAlert("このメールアドレスのアカウントはすでに存在しています。")
                    }
                }else {
                    self.savePassword(password)
                    self.segueToPrivacyPolicy()
                }
            })
        }
    }
    
    @IBAction func sendPasswordResetWithEmail(_ sender: Any) {
        guard let email = self.emailTextField.text else { return }
        if email == "" {
            self.showAlert("メールアドレスを入力してください。")
        } else {
            self.showDialog("パスワードの再設定", "\(email)にパスワード再設定用のメールを送りますか？") {
                Auth.auth().sendPasswordReset(withEmail: email, completion: { (error) in
                    if let error = error {
                        self.showAlert(error.localizedDescription)
                    } else {
                        self.showDialog("送信しました。", "\(email)", complition: nil)
                    }
                })
            }
        }
    }
    
    private func savePassword(_ password: String) {
        let userDefault = UserDefaults.standard
        userDefault.set(password, forKey: "password")
    }
}

extension LoginViewController {
    
    fileprivate func segueToPrivacyPolicy() {
        let storyboard = UIStoryboard(name: "PrivacyPolicyViewController", bundle: nil)
        let initalViewController = storyboard.instantiateInitialViewController()
        self.present(initalViewController!, animated: true, completion: nil)
    }
    
    //segue to editUserInfoViewController
    fileprivate func segueToEditUserInfo() {
        let storyboard = UIStoryboard(name: "EditUserInfoViewController", bundle: nil)
        let initalViewController = storyboard.instantiateInitialViewController()
        self.present(initalViewController!, animated: true, completion: nil)
    }
}
