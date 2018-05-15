//
//  EventDetailTableViewCell.swift
//  hands
//
//  Created by 山浦功 on 2018/05/13.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import UIKit

class EventDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var createdLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.titleLabel.adjustsFontSizeToFitWidth = true
        self.createdLabel.adjustsFontSizeToFitWidth = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateCell(event: Event) {
        self.titleLabel.text = event.title
        self.createdLabel.text = DateUtils().stringFromDate(date: event.created_at)
        self.bodyLabel.text = event.body
    }
}
