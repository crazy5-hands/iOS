//
//  ColorManager.swift
//  hands
//
//  Created by 山浦功 on 2018/01/22.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import Foundation
import UIKit


class ColorManager {
    
    func lineLoginButtonBaseColor() -> UIColor{
        return UIColor(red: 0, green: 195/255, blue: 0, alpha: 1)
    }
    
//    func lineLoginButtonHoverColor() -> UIColor {
//        return UIColor(red: 0, green: 227/255, blue: 0, alpha: 1)
//    }
    
    func lineLoginButtonPressColor() -> UIColor {
        return UIColor(red: 0, green: 179/255, blue: 0, alpha: 1)
    }
    
    func lineLoginButtonDisableColor() -> UIColor {
        return UIColor(red: 198/255, green: 198/255, blue: 198/255, alpha: 1)
    }
}
