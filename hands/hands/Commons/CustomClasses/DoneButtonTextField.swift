//
//  ButtonTextField.swift
//  hands
//
//  Created by 山浦功 on 2018/04/28.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import Foundation
import UIKit


class DoneButtonTextField: UITextField{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit(){
        let tools = UIToolbar()
        tools.frame = CGRect(x: 0, y: 0, width: frame.width, height: 40)
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let closeButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.closeButtonTapped))
        tools.items = [spacer, closeButton]
        self.inputAccessoryView = tools
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(red: 0.79, green: 0.79, blue: 0.79, alpha: 1).cgColor
        self.layer.cornerRadius = 8.0
        self.layer.masksToBounds = true
    }
    
    @objc private func closeButtonTapped(){
        self.endEditing(true)
        self.resignFirstResponder()
    }
}
