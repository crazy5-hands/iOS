//
//  TextTableViewCell.swift
//  hands
//
//  Created by 山浦功 on 2018/01/04.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import UIKit

protocol TextTableViewCellDelegate{
    func textData(_ text: String)
}

class TextTableViewCell: UITableViewCell, UITextFieldDelegate{
    
    @IBOutlet weak var textField: CustomTextField!
    
    var title: String?
    var delegate: TextTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textField.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        self.title = textField.text
        self.delegate?.textData(textField.text!)
        return true
    }
    
    func getTitle() -> String{
        return self.textField.text!
    }
}
