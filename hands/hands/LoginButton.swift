//
//  LoginButton.swift
//  hands
//
//  Created by 山浦功 on 2018/01/22.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import Foundation
import UIKit


//Login button
class LineLoginButton: UIButton{
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.backgroundColor = ColorManager().lineLoginButtonPressColor()
        self.setImage(#imageLiteral(resourceName: "btnLoginPress"), for: .highlighted)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        self.backgroundColor = ColorManager().lineLoginButtonBaseColor()
        self.setImage(#imageLiteral(resourceName: "btnLoginBase"), for: .normal)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        self.backgroundColor = ColorManager().lineLoginButtonBaseColor()
        self.setImage(#imageLiteral(resourceName: "btnLoginBase"), for: .normal)
    }
}

