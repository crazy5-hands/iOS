//
//  LoginInteractor.swift
//  hands
//
//  Created by 山浦功 on 2018/09/07.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import Foundation
import FirebaseAuth

final class LoginInteractor: LoginInteractorInterface {
    
    func signIn(email: String, password: String, complition: @escaping ((RequestResult) -> Void)) {
        var result = RequestResult.success
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let error = error {
                result = RequestResult.failure(message: error.localizedDescription)
            }
            complition(result)
        }
    }
    
    func signUp(email: String, password: String, complition: @escaping ((RequestResult) -> Void)) {
        var result = RequestResult.success
        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
            if let error = error {
                result = RequestResult.failure(message: error.localizedDescription)
            }
            complition(result)
        })
    }
    
    func savePassword(_ password: String) {
        let userDefault = UserDefaults.standard
        userDefault.set(password, forKey: "password")
    }
    
    func sendEmailToResetPassword(reset email: String) {
        Auth.auth().sendPasswordReset(withEmail: email, completion: nil)
    }
}
