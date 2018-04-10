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
    
    private var handle: AuthStateDidChangeListenerHandle?
    private var email: String?
    private var password: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        handle = Auth.auth().addStateDidChangeListener({ (auth, user) in
            })
    }
    
    //新しいユーザーを登録
    func signUp() {
        Auth.auth().createUser(withEmail: email!, password: password!, completion: { (user, error) in
            })
    }
    
    //既存のユーザーがログインをする
    private func signIn() {
        Auth.auth().signIn(withEmail: email!, password: password!) { (user, error) in
            
        }
    }
}
