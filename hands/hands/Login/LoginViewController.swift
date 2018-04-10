//
//  LoginViewController.swift
//  hands
//
//  Created by 山浦功 on 2018/04/10.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var changeStatusSegmentedControl: UISegmentedControl!
    
    private var handle: AuthStateDidChangeListenerHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        handle = Auth.auth().addStateDidChangeListener({ (auth, user) in
            })
    }
    
    //サーバーで確認
    @IBAction func submit(_ sender: Any) {
        switch self.changeStatusSegmentedControl.selectedSegmentIndex {
        case 0:
            self.signIn()
        case 1:
            self.signUp()
        default:
            self.signUp()
        }
    }
    
    
    //create new user
    private func signUp() {
        //show processing
        let processingView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        processingView.center = self.view.center
        self.view.addSubview(processingView)
        processingView.startAnimating()
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
            
            //remove processing
            if processingView.isAnimating == true {
                processingView.stopAnimating()
            }
            self.view.willRemoveSubview(processingView)
            
            if let error = error {
                if error.localizedDescription == "The email address is already in use by another account." {
                    self.showAlert("このメールアドレスのアカウントはすでに存在しています。")
                }
                return
            }else {
                print(user?.email)
                print(user?.uid)
            }
            })
    }
    
    //login existing user
    private func signIn() {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            
        }
    }
    
    //show alert
    func showAlert(_ message: String) {
        let alert = UIAlertController(title: "エラー", message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(defaultAction)
        present(alert, animated: true, completion: nil)
    }
    
    //show processing view
//    func showProcessing() {
//        let processingView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
//        processingView.center = self.view.center
//        self.view.addSubview(processingView)
//        processingView.startAnimating()
//        self.view.willRemoveSubview(processingView)
//    }
}
