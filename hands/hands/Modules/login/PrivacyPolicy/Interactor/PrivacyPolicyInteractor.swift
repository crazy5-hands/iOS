//
//  PrivacyPolicyInteractor.swift
//  hands
//
//  Created by 山浦功 on 2018/09/08.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import Foundation

final class PrivacyPolicyInteractor: PrivacyPolicyInteractorInterface {
    
    private let key = "privacyPolicy"
    
    func saveAgreement(_ value: Bool) {
        UserDefaults.standard.setValue(value, forKey: self.key)
    }
    
    func getAgreement() -> Bool {
        return UserDefaults.standard.bool(forKey: self.key)
    }
}
