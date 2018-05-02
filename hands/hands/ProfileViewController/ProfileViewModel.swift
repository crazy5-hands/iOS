//
//  ProfileViewModel.swift
//  hands
//
//  Created by 山浦功 on 2018/05/02.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import Foundation
import Firebase

class ProfileViewModel {
    
    var user: User?
    private let db = Firestore.firestore()
    private var docRef: DocumentReference?
    
    init() {
        let displayName = Auth.auth().currentUser?.displayName
        self.docRef = db.collection("users").document(displayName!)
        self.docRef?.getDocument(completion: { (document, error) in
            if document != nil {
                self.user = User(dictionary: (document?.data())!)
                print("hellow")
                print(self.user?.id)
            }else {
                print(error?.localizedDescription ?? "error")
            }
        })
    }
}
