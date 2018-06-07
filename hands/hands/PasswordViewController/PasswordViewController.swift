//
//  PasswordViewController.swift
//  hands
//
//  Created by 山浦功 on 2018/06/07.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import UIKit
import Firebase

class PasswordViewController: TextFieldViewController {

    @IBOutlet weak var passwordTextField: DoneButtonTextField!
    private var indicator: UIActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.passwordTextField.isSecureTextEntry = true
        self.indicator = UIActivityIndicatorView()
        self.indicator?.tintColor = .black
        self.indicator?.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        self.view.addSubview(self.indicator!)
        DispatchQueue.global(qos: .userInitiated).async {
            let user = Auth.auth().currentUser
            let credential = AuthCredential?
            credential = Prompt
            user?.reauthenticate(with: credential, completion: { (error) in
                if let error = error {
                    self.showAlert("ユーザーの再認証に失敗しました。パスワードやメールアドレスの更新はできません。")
                    print(error.localizedDescription)
                }
            })
        }
    }

    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func update(_ sender: Any) {
        UIApplication.shared.beginIgnoringInteractionEvents()
        self.indicator?.startAnimating()
        if let password = self.passwordTextField.text {
            Auth.auth().currentUser?.updatePassword(to: password, completion: { (error) in
                self.indicator?.stopAnimating()
                UIApplication.shared.endIgnoringInteractionEvents()
                if let error = error {
                    self.showAlert(error.localizedDescription)
                } else {
                    self.showDialog("更新に成功", "この画面を閉じますか", complition: {
                        self.dismiss(animated: true, completion: nil)
                    })
                }
            })
        }
    }
}
