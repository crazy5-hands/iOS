//
//  ProfileTableViewCell.swift
//  hands
//
//  Created by 山浦功 on 2018/01/30.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import UIKit

protocol ProfileTableViewCellDelegate {
    func tappedAddFriendButton()
}

class ProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var sumOfWillJoinLabel: UILabel!
    @IBOutlet weak var sumOfJoinedLabel: UILabel!
    
    var delegate: ProfileTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func addFriend(_ sender: Any) {
        self.delegate?.tappedAddFriendButton()
    }
}


extension ProfileTableViewCell{
    
    // set Data to UIImageView and Labels
    func updateCell(profileImage: UIImage?, userName: String, sumOfWillJoin: Int, sumOfJoined: Int){
        if profileImage == nil {
            //set non profile image
        }else {
            profileImageView.image = profileImage!
        }
        userNameLabel.text = userName
        sumOfWillJoinLabel.text = String(sumOfWillJoin)
        sumOfJoinedLabel.text = String(sumOfJoined)
    }
}
