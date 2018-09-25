//
//  EventTableViewCell.swift
//  hands
//
//  Created by 山浦功 on 2018/04/28.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import UIKit
import Firebase

class EventTableViewCell: UITableViewCell {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var createAtLabel: UILabel!
    var eventKey: String?
    var eventRef: DatabaseReference!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.titleLabel.adjustsFontSizeToFitWidth = true
        self.createAtLabel.adjustsFontSizeToFitWidth = true
    }
    
    func updateCell(eventKey: String, title: String, body: String, createAt: NSDate) {
        self.eventKey = eventKey
        self.titleLabel.text = title
        self.bodyLabel.text = body
        self.createAtLabel.text = DateUtils().stringFromDate(date: createAt)
    }
}
