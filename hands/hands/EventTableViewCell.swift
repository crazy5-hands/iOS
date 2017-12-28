//
//  EventTableViewCell.swift
//  hands
//
//  Created by 山浦功 on 2017/12/27.
//  Copyright © 2017年 KoYamaura. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class EventTableViewCell: UITableViewCell {

    var disposeBag = DisposeBag()
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var start: UILabel!
    @IBOutlet weak var member: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        self.prepareForReuse()
        self.disposeBag = DisposeBag()
    }
    
    func update(_ object: EventViewModel){
        title.text = object.title
        start.text = DateUtils.stringFromDate(date: object.start)
        var names = String()
        for i in object.memberName{
            names = names + i
        }
        member.text = names
    }
}
