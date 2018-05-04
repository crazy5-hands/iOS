//
//  EditUserInfoViewModel.swift
//  hands
//
//  Created by 山浦功 on 2018/04/12.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import Foundation
import RxSwift
import Firebase

class EditUserInfoViewModel{
    
    var displayName = Variable<String>("")
    let shouldSubmit: Observable<Bool>
    var user: User?
    private let uid = Auth.auth().currentUser?.uid
    private let db = Firestore.firestore()
    private var docRef: DocumentReference?
    
    init() {
        self.shouldSubmit = self.displayName.asObservable().map({ text -> Bool in
            0 < text.count && text.count <= 15
        })
        self.docRef = self.db.collection("users").document(self.uid!)
        //存在チェック
        self.db.collection("users").whereField("id", isEqualTo: self.uid!).getDocuments { (snapshot, error) in
            if let snapshot = snapshot {
                if snapshot.documents.count == 0 { // user data doesn't exist
                    self.user = User(id: self.uid!, username: "", note: "", photo: "")
                }else { // user data exists
                    self.user = User(dictionary: snapshot.documents[0].data())
                }
            }else {
                print(error?.localizedDescription ?? "can't get data")
                self.user = User(id: self.uid!, username: "", note: "", photo: "")
            }
        }
    }
    
    func updateData(username: String){
        self.user?.username = username
        self.db.collection("users").document(self.uid!).setData((self.user?.dictionary)!)
    }
    
//    func update(image: UIImage?) -> Bool {
////        var newPhotoURL:URL?
////        if image != nil {
////            newPhotoURL = self.storageModel.uplodeImage(image!, url: self.displayName.value + ".jpg")
////        }
//////        return self.userModel.updateUser(self.displayName.value, newPhotoURL)
//    }
}
