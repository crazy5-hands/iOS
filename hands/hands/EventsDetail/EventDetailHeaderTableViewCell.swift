//
//  EventDetailHeaderTableViewCell.swift
//  hands
//
//  Created by 山浦功 on 2018/01/26.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import UIKit

class EventDetailHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var eventDateLabel: UILabel!
    
    var data:EventViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        testdata()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        testdata()
        // Configure the view for the selected state
    }
    
    func update(_ data: EventViewModel){
        self.eventNameLabel.text = data.title
        self.eventDateLabel.text = DateUtils.stringFromDate(date: data.start)
    }
    
    func testdata(){
        eventNameLabel.text = "hello "
        eventDateLabel.text = "2017/1/12"
    }
}
