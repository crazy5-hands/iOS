//
//  DeleteTableViewCell.swift
//  hands
//
//  Created by 山浦功 on 2018/05/26.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import UIKit

class DeleteTableViewCell: UITableViewCell {

    @IBOutlet weak private var deleteLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateCell(title: String) {
        self.deleteLabel.text = title
    }
    
}
