//
//  MemoTableViewCell.swift
//  hands
//
//  Created by 山浦功 on 2018/01/28.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import UIKit

class MemoTableViewCell: UITableViewCell {

    @IBOutlet weak var memoTextView: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func update(_ memo: String) {
        memoTextView.text = memo
    }
}