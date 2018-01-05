//
//  TextTableViewCell.swift
//  hands
//
//  Created by 山浦功 on 2018/01/04.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import UIKit

class TextTableViewCell: UITableViewCell {
    
    @IBOutlet weak var textField: CustomTextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func getTitle() -> String{
        return textField.text!
    }
}
