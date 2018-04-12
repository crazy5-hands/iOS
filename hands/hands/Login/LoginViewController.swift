//
//  LoginViewController.swift
//  hands
//
//  Created by 山浦功 on 2018/04/10.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var changeStatusSegmentedControl: UISegmentedControl!
//    @IBOutlet private weak var scrollView: UIScrollView!
    
    private var handle: AuthStateDidChangeListenerHandle?
    private var activeTextField: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //delegate of TextField
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        handle = Auth.auth().addStateDidChangeListener({ (auth, user) in
            })
        
        //set notification for TextField
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(LoginViewController.handleKeyboardWillShowNotification(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        notificationCenter.addObserver(self, selector: #selector(LoginViewController.handleKeyboardWillHideNotification(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    //send email and password to server
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
                    print("success login")
                    UserDefaults.standard.set(user?.uid, forKey: "uid")
                    
                    if UserDefaults.standard.string(forKey: "uid") != nil {
//                        self.segueToMain()
                        print("画面遷移")
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
//                    self.segueToMain()
                }
            })
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        activeTextField = textField
        return true
    }
    
    @objc private func handleKeyboardWillShowNotification(_ notification: Notification) {
        let userInfo = notification.userInfo!
        let keyboardSize = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardY = self.view.frame.size.height - keyboardSize.height
        let editingTextFieldY: CGFloat = (self.activeTextField?.frame.origin.y)!
        
        if editingTextFieldY > keyboardY - 60 {
            UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveEaseIn, animations: {
                self.view.frame = CGRect(x: 0, y: self.view.frame.origin.y - (editingTextFieldY - (keyboardY - 60)), width: self.view.bounds.width , height: self.view.bounds.height)
            }, completion: nil)
        }
    }
    
    @objc private func handleKeyboardWillHideNotification(_ notification: Notification) {
        UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveEaseIn, animations: {
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        }, completion: nil)
    }
}

extension LoginViewController {
    
    //segue to main tab ViewController
    fileprivate func segueToMain() {
        let storyboard = UIStoryboard(name: "MainTabViewController", bundle: nil)
        let initalViewController = storyboard.instantiateInitialViewController()
        self.present(initalViewController!, animated: true, completion: nil)
    }
}
