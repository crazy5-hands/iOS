//
//  EditCostViewController.swift
//  hands
//
//  Created by 山浦功 on 2018/05/21.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import UIKit

class EditCostViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet private weak var numberTextField: UITextField!
    var eventId: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.numberTextField.delegate = self
        self.numberTextField.keyboardType = .numberPad
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let invalidCharacters = CharacterSet(charactersIn: "0123456789").inverted
        return string.rangeOfCharacter(from: invalidCharacters, options: [], range:  string.startIndex ..< string.endIndex) == nil
    }
}
