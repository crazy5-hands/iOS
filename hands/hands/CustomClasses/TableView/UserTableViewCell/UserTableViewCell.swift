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

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var folllowButton: UIButton!
    private let id = Auth.auth().currentUser?.uid
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.nameLabel.adjustsFontSizeToFitWidth = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func updateCell(user: User) {
        let semaphore = DispatchSemaphore.init(value: 0)
        self.nameLabel.text = user.username
        if self.id == user.id {
            self.folllowButton.setTitle("自分", for: .disabled)
            semaphore.signal()
        }else  {
            let follows = FollowUtil().getFollows(user_id: self.id!)
            for follow in follows {
                if follow.follow_id == user.id {
                    self.folllowButton.setTitle("フォロー中", for: .normal)
                    break
                }
            }
            semaphore.signal()
        }
        semaphore.wait()
    } // end updatecell
}
