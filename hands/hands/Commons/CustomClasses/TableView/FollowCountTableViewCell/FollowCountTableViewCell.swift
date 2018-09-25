//
//  FollowCountTableViewCell.swift
//  hands
//
//  Created by 山浦功 on 2018/05/17.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import UIKit

class FollowCountTableViewCell: UITableViewCell {

    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var countLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.countLabel.adjustsFontSizeToFitWidth = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateCell(title: String, count: Int) {
        self.titleLabel.text = title
        self.countLabel.text = "\(count)"
    }
    
}
