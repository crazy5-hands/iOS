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
//    @IBOutlet private weak var scrollView: UIScrollView!
    
    private var handle: AuthStateDidChangeListenerHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //delegate of TextField
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
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
        
        if self.changeStatusSegmentedControl.selectedSegmentIndex == 0 {
            Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
                
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
                    UserDefaults.standard.set(user?.uid, forKey: "uid")
                    
                    if UserDefaults.standard.string(forKey: "uid") != nil {
                        self.segueToEditUserInfo()
                    }else {
                        self.showAlert("アカウントを正常にサインインできませんでした。")
                    }
                }
            }
        }else {
            //create new user
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
                
                //remove processing
                processingView.stopAnimating()
                self.view.willRemoveSubview(processingView)
                
                if let error = error {
                    if error.localizedDescription == "The email address is already in use by another account." {
                        self.showAlert("このメールアドレスのアカウントはすでに存在しています。")
                    }
                    return
                }else {
                    self.segueToEditUserInfo()
                }
            })
        }
    }
}

extension LoginViewController {
    
    //segue to editUserInfoViewController
    fileprivate func segueToEditUserInfo() {
        let storyboard = UIStoryboard(name: "EditUserInfoViewController", bundle: nil)
        let initalViewController = storyboard.instantiateInitialViewController()
        self.present(initalViewController!, animated: true, completion: nil)
    }
}
