//
//  PrivacyPolicyViewModel.swift
//  hands
//
//  Created by 山浦功 on 2018/05/29.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import Foundation
import RxSwift

class PrivacyPolicyViewModel {
    
    let count = Variable<Int>(0)
    let acceptPrivacyPolocy: Observable<Bool>
    
    init() {
        self.acceptPrivacyPolocy = self.count.asObservable().map({ (count) -> Bool in
            count % 2 == 1
        })
    }
}
