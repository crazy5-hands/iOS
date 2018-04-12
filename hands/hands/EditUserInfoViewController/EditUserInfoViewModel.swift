//
//  EditUserInfoViewModel.swift
//  hands
//
//  Created by 山浦功 on 2018/04/12.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import Foundation
import RxSwift

class EditUserInfoViewModel{
    
    private let userModel = UserModel()
    
    var displayName = Variable<String>("")
    let shouldSubmit: Observable<Bool>
    
    init() {
        self.displayName = Variable<String>((userModel.getUserProfile()?.displayName)!)
        self.shouldSubmit = self.displayName.asObservable().map({ text -> Bool in
            0 < text.count && text.count <= 15
        })
    }
    
    func update() -> Bool {
        let user = self.userModel.getUserProfile()
//        user?.displayName = self.displayName.value
        return self.userModel.updateUser(user!)
    }
}
