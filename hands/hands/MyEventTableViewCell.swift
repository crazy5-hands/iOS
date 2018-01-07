//
//  MyEventTableViewCell.swift
//  hands
//
//  Created by 山浦功 on 2018/01/08.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import UIKit

class MyEventTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var ownerLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func update(_ object: EventViewModel){
        titleLabel.text = object.title
        startLabel.text = DateUtils.stringFromDate(date: object.start)
        ownerLabel.text = object.ownerName
    }
}
