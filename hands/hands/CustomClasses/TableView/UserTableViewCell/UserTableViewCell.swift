//
//  UserTableViewCell.swift
//  hands
//
//  Created by 山浦功 on 2018/04/29.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import UIKit
import Firebase

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var followstatusLabel: UILabel!
    private let id = Auth.auth().currentUser?.uid
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.nameLabel.adjustsFontSizeToFitWidth = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func updateCell(user: User) {
        self.nameLabel.text = user.username
        if self.id == user.id {
            self.followstatusLabel.text = ""
        }else  {
            FollowUtil().getFollows(user_id: self.id!) { (follows) in
                for follow in follows {
                    if follow.follow_id == user.id {
                        self.followstatusLabel.text = "フォロー中"
                    }
                }
                
            }
        }
    } // end updatecell
}
