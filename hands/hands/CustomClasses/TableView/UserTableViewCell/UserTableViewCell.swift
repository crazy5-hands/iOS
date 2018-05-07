//
//  UserTableViewCell.swift
//  hands
//
//  Created by 山浦功 on 2018/04/29.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func updateCell(image: UIImage, name: String){
        self.profileImageView.image = image
        self.nameLabel.text = name
        
    }
}
