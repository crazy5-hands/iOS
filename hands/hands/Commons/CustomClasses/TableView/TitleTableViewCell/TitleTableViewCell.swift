//
//  TitleTableViewCell.swift
//  hands
//
//  Created by 山浦功 on 2018/06/07.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import UIKit

class TitleTableViewCell: UITableViewCell {

    @IBOutlet private weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initalSet()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func initalSet() {
        self.titleLabel.adjustsFontSizeToFitWidth = true
    }
    
    func updateCell(title: String) {
        self.titleLabel.text = title
    }
}
