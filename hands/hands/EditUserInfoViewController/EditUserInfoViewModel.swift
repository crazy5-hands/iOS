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
    var userPhoto: UIImage?
    private let uid = Auth.auth().currentUser?.uid
    private let db = Firestore.firestore()
    private var docRef: DocumentReference?
    
    init() {
        
        //set up rx
        self.shouldSubmit = self.displayName.asObservable().map({ text -> Bool in
            0 < text.count && text.count <= 15
        })
        
        let dispatchGroup = DispatchGroup()
        let queue = DispatchQueue(label: "com.GCD.barrier", attributes: .concurrent)
        
        self.db.collection("users").whereField("id", isEqualTo: self.uid!).getDocuments { (snapshot, error) in
            if let snapshot = snapshot {
                if snapshot.documents.count == 0 { // user data doesn't exist
                    self.user = User(id: self.uid!, username: "", note: "", photo: "")
                }else { // user data exists
                    self.user = User(dictionary: snapshot.documents[0].data())
                    let path = "users/" + self.uid! + ".jpg"
                    self.userPhoto = PhotoUtil().getPhoto(path: path)
                }
            }else {
                print(error?.localizedDescription ?? "can't get data")
                self.user = User(id: self.uid!, username: "", note: "", photo: "")
            }
        }
        dispatchGroup.leave()
        //存在チェック
        
    }
    
    func getPhoto() -> UIImage? {
        let path = "users/" + self.uid! + ".jpg"
        return PhotoUtil().getPhoto(path: path)
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
