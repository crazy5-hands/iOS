//
//  EmailViewController.swift
//  hands
//
//  Created by 山浦功 on 2018/06/07.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import UIKit
import FirebaseAuth

class EmailViewController: TextFieldViewController {

    @IBOutlet weak var emailTextField: DoneButtonTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func update(_ sender: Any) {
        if let email = self.emailTextField.text {
            Auth.auth().currentUser?.updateEmail(to: email, completion: { (error) in
                if let error = error {
                    // fail to update your email
                    self.showAlert(error.localizedDescription)
                }
            })
        } else {
            //text field is empty
            self.showAlert("メールアドレスが空です。メールアドレスを入力してください。")
        }
    }
}
