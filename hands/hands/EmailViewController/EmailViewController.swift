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
    @IBOutlet weak var oldEmailLabel: UILabel!
    @IBOutlet weak var explainLabel: UILabel!
    private var indicator: UIActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.indicator = UIActivityIndicatorView()
        self.indicator?.tintColor = .black
        self.indicator?.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        self.view.addSubview(self.indicator!)
        self.emailTextField.keyboardType = .emailAddress
        DispatchQueue.global(qos: .userInitiated).async {
            let email = Auth.auth().currentUser?.email
            DispatchQueue.main.async {
                self.oldEmailLabel.text = email
            }
            if let user = Auth.auth().currentUser {
                let email = user.email
                guard let password = self.getPassword() else { return }
                let credential = EmailAuthProvider.credential(withEmail: email!, password: password)
                user.reauthenticate(with: credential, completion: { (error) in
                    if let error = error {
                        DispatchQueue.main.async {
                            self.showAlert(error.localizedDescription)
                        }
                    }
                })
            }
        }
    }
    
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func update(_ sender: Any) {
        UIApplication.shared.beginIgnoringInteractionEvents()
        self.indicator?.startAnimating()
        if let email = self.emailTextField.text  {
            Auth.auth().currentUser?.updateEmail(to: email, completion: { (error) in
                UIApplication.shared.endIgnoringInteractionEvents()
                self.indicator?.stopAnimating()
                if let error = error {
                    // fail to update your email
                    self.showAlert(error.localizedDescription)
                } else {
                    self.showDialog("更新に成功しました。", "この画面を閉じますか？", complition: {
                        self.dismiss(animated: true, completion: nil)
                    })
                }
            })
        } else {
            //text field is empty
            self.showAlert("メールアドレスが空です。メールアドレスを入力してください。")
        }
    }
    
    private func getPassword() -> String? {
        let userDefault = UserDefaults.standard
        return userDefault.string(forKey: "password")
    }
}
