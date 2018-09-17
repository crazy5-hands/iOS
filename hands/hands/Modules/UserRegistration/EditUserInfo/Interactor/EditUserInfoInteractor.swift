//
//  EditUserInfoInteractor.swift
//  hands
//
//  Created by 山浦功 on 2018/09/10.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import Foundation
import FirebaseAuth

final class EditUserInfoInteractor: EditUserInfoInteractorInterface {

    func getUser() -> User? {
        var result: User? = nil
        guard let id = Auth.auth().currentUser?.uid else { return result }
        UserUtil.getUser(id: id) { (user) in
            guard let user = user else { return }
            result = user
        }
        return result
    }

    func updateUser(displayName: String, note: String) {
        guard let id = Auth.auth().currentUser?.uid else { return }
        UserUtil.putUser(id: id, user: User(id: id, username: displayName, note: note, photo: ""), complition: nil)
    }
}
