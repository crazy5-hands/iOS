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
    
    private let userModel = UserModel()
    private let storageModel = StorageModel()
    var displayName = Variable<String>("")
    let shouldSubmit: Observable<Bool>
    
    init() {
        if userModel.getUserProfile()?.displayName == nil {
            self.displayName = Variable<String>("")
        }else {
            self.displayName = Variable<String>((userModel.getUserProfile()?.displayName)!)
        }
        self.shouldSubmit = self.displayName.asObservable().map({ text -> Bool in
            0 < text.count && text.count <= 15
        })
    }
    
    func update(image: UIImage?) -> Bool {
        let newPhotoURL = self.storageModel.uplodeImage(image!, url: self.displayName.value + ".jpg")
        return self.userModel.updateUser(self.displayName.value, newPhotoURL)
    }
}
