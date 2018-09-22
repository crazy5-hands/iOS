//
//  PrivacyPolicyPresenter.swift
//  hands
//
//  Created by 山浦功 on 2018/09/08.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import Foundation

final class PrivacypolicyPresenter: PrivacyPolicyPresenterInterface {
    
    private weak var view: PrivacyPolicyViewInterface?
    private var interactor: PrivacyPolicyInteractorInterface?
    private var wireframe: PrivacyPolicyWireframeInterface?
    
    func showNextView(agree: Bool) {
        self.interactor?.saveAgreement(agree)s
        self.wireframe?.showEditUserInfo()
    }
    
    func dismissView() {
        self.wireframe.dismissView()
    }
}
