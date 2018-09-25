//
//  UserDetailTableViewCell.swift
//  hands
//
//  Created by 山浦功 on 2018/05/17.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import UIKit

class UserDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var noteLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.usernameLabel.adjustsFontSizeToFitWidth = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateCell(user: User) {
        self.usernameLabel.text = user.username
        self.noteLabel.text = user.note
    }
}
