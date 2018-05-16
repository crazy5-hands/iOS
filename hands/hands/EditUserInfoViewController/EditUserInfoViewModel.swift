//
//  EditUserInfoViewModel.swift
//  hands
//
//  Created by 山浦功 on 2018/04/12.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import Foundation
import Firebase

class EditUserInfoViewModel{
    
    private var user: User?
    private let db = Firestore.firestore()
    private let uid = Auth.auth().currentUser?.uid
    
    init(complition: @escaping (Bool) -> Void) {
        UserUtil().getUser(id: self.uid!) { (user) in
            if let user = user {
                self.user = user
                complition(true)
            }else {
                complition(false)
            }
        }
    }
    
    func getUser() -> User? {
        return self.user
    }
    
    func getPhoto() -> UIImage? {
        if let user = self.user {
            if user.photo != "" {
                return PhotoUtil().getPhoto(path: user.photo)
            }
        }
        return UIImage(named: "icon-userPhoto.png")
    }
    
    func updateData(username: String, photo: UIImage?, url: URL?, handler: (Bool) -> Void){
        var result: Bool = false
        self.user?.username = username
        let path = "users/" + self.uid! + ".jpg"
        if let url = url {
            PhotoUtil().putPhoto(path: path, image: photo!, imageURL: url) { (stringURL) in
                if let stringURL = stringURL {
                    self.user?.photo = stringURL
                    self.db.collection("users").document(self.uid!).setData((self.user?.dictionary)!)
                    result = true
                    handler(result)
                }else {
                    print("fail to update photo")
                    handler(result)
                }
            }
        }
    }
}
