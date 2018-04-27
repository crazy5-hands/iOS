//
//  User.swift
//  hands
//
//  Created by 山浦功 on 2018/04/11.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import Foundation
import Firebase


class UserModel{
    
    let user = Auth.auth().currentUser
    
    //ユーザーの作成
    func createUser() {
        
    }
    
    //現在ログイン中のユーザーの取得 -- 使わないとおもわれる
    func getUserInfo(){

    }
    
    //プロフィールの取得
    func getUserProfile() -> User? {
//        let user = Auth.auth().currentUser
//        if let user = user {
//            return user
//        }
        return nil
    }
    
    //ユーザーの更新
    func updateUser(_ displayName: String? , _ photoURL: URL?) -> Bool {
        var result = true
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = displayName ?? self.user?.displayName
        if photoURL != nil {
            changeRequest?.photoURL = photoURL ?? self.user?.photoURL
        }
        changeRequest?.commitChanges(completion: { (error) in
            if error != nil {
                print("更新に失敗")
                result = false
            }
        })
        return result
    }

    //メールアドレスの設定
    func setEmail(_ email: String) -> Bool {
        var result = true
        Auth.auth().currentUser?.updateEmail(to: email, completion: { (error) in
            if error != nil {
                result = false
            }
        })
        return result
    }
    
    //確認メールを送信する
    func sendEmailVerify() -> Bool {
        var result = true
        Auth.auth().currentUser?.sendEmailVerification(completion: { (error) in
            if error != nil {
                result = false
            }
        })
        return result
    }
    
    //パスワードを設定する
    func setPassword() {
        
    }
    
    //パスワードを再設定メールを送信する
    func sendEmailSettingPassword() {
        
    }
    
    //ユーザーを削除する
    func deleteUser() {
        
    }
    
    //ユーザーの再認証
    func reVerifyUser() {
        
    }
}

class User: NSObject {
    
    private var ref: DatabaseReference!
    var uid: String
    var username: String
    var photoURL: URL
    var note: String
    var own = [String]() //event id
    var join = [String]() //event id
    var follow = [String]() //user id
    var follower = [String]() //user id
    
    init(username: String) {
        self.username = username
        self.ref = Database.database().reference()
        let db = self.ref.child("users").child(self.uid)
        db.observeSingleEvent(of: .value, with: { snapchat in
            
        }) { error in
            print(error.localizedDescription)
        }
    }
    
    convenience override init() {
        self.init(username: "")
    }
    
    func getData(){
        
    }
}
