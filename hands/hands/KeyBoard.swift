//
//  KeyBoard.swift
//  hands
//
//  Created by 山浦功 on 2018/01/01.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import Foundation
import UIKit


/// MARK - キーボードに「閉じるボタン」の追加
class KeyBoard: UIToolbar {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit(){
        self.frame = CGRect(x: 0, y: 0, width: frame.width, height: 40)
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let closeButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(KeyBoard.closeButtonTapped))
        self.items = [spacer, closeButton]
    }
    
    func closeButtonTapped(){
        self.endEditing(true)
    }
}
