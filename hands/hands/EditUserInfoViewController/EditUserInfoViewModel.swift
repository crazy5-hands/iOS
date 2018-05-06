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
    private let storage = Storage.storage()
    private var photoRef: StorageReference?
    
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
                    if self.user?.photo == "" {
                        let usersRef = self.storage.reference().child("users")
                        let fileName = "\(self.uid!)" + ".jpg"
                        self.photoRef = usersRef.child(fileName)
                    }else {
                        self.photoRef = self.storage.reference().child((self.user?.photo)!)
                    }
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
    
    
    func getUserPhoto() {
        self.photoRef?.getData(maxSize: 1 * 1024 * 1024, completion: { (data, error) in
            if let data = data {
                self.userPhoto = UIImage(data: data)
            }else {
                print(error?.localizedDescription ?? "error getUserPhoto")
            }
        })
    } //end getUserPhoto
    
    func updateUserPhoto(image: UIImage?) {
        if let image = image {
            if image != self.userPhoto {
                // process to upload
                let data = UIImageJPEGRepresentation(image, CGFloat(1.0))
                let uploadTask = self.photoRef?.putData(data!, metadata: nil){ (metadata, error) in
                    if let metadata = metadata {
                        self.user?.photo = (metadata.downloadURL()?.absoluteString)!
                    }else {
                        print(error?.localizedDescription ?? "error updateUserPhoto")
                    }
                }
                uploadTask?.resume()
            }
        }
    } // end updateUserphoto
}
