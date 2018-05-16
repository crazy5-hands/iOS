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
    
    func updateData(username: String, photo: UIImage?, imageURL: URL?, handler: @escaping (Bool) -> Void){
        let semaphore = DispatchSemaphore(value: 0)
        var photoURL = ""
        if imageURL == nil{
            photoURL = ""
            semaphore.signal()
        }else { //upload photo
            let path = "users/" + self.uid! + ".jpg"
//            PhotoUtil().putPhoto(path: path, image: photo!) { (stringURL) in
//                if let stringURL = stringURL {
//                    photoURL = stringURL
//                }
//                semaphore.signal()
//            }
            print(imageURL?.absoluteString)
            PhotoUtil().putPhotoWithURL(path: path, imageURL: imageURL!) { (stringURL) in
                if let stringURL = stringURL {
                    photoURL = stringURL
                }
                semaphore.signal()
            }
        }
        semaphore.wait()
        let user = User(id: self.uid!, username: username, note: (self.user?.note)!, photo: photoURL)
        UserUtil().putUser(id: self.uid!, user: user, complition: { (result) in
            handler(result)
        })

    }
}
