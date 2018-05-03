//
//  ProfileViewModel.swift
//  hands
//
//  Created by 山浦功 on 2018/05/02.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import Foundation
import Firebase

protocol ProfileViewModelDelegate {
    func loadData()
}

class ProfileViewModel {
    
    var user: User?
    private let db = Firestore.firestore()
    private var docRef: DocumentReference?
    var delegate: ProfileViewModelDelegate?
    
    init() {
        let displayName = Auth.auth().currentUser?.displayName
        self.docRef = db.collection("users").document(displayName!)
        self.user = User()
//        self.docRef?.getDocument(completion: { (document, error) in
//            if document != nil {
//                self.user = User(dictionary: (document?.data())!)
//                print(self.user?.id)
//            }else {
//                print(error?.localizedDescription ?? "error")
//            }
//        })
    }
    
    func getData() {
        self.docRef?.getDocument(completion: { (document, error) in
            if document != nil {
                self.user = User(dictionary: (document?.data())!)
                print(self.user?.id)
                self.delegate?.loadData()
            }else {
                print(error?.localizedDescription ?? "error")
            }
        })
    }
}
