//
//  LoginInterfaces.swift
//  hands
//
//  Created by 山浦功 on 2018/09/02.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import UIKit

protocol LoginWireframeInterface: WireframeInterface {
    
    /// Loginの画面を表示
    func configureModule() -> UIViewController
    
    /// Loginに成功
    /// プライバシーポリシーに同意していない場合、
    /// または、プライバシーポリシーが更新された場合に表示
    func showPrivatePoilicyScreenAsRoot()
    
    /// Loginに成功
    /// ユーザー名、ひとことの設定をしていない場合に遷移
    func showEditUserInfoScreenAsRoot()
    
    /// Loginに成功
    /// メインの画面に遷移
    func showMainScreenAsRoot()
}
