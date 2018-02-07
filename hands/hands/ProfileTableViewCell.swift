//
//  ProfileTableViewCell.swift
//  hands
//
//  Created by 山浦功 on 2018/01/30.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var sumOfWillJoinLabel: UILabel!
    @IBOutlet weak var sumOfJoinedLabel: UILabel!
    @IBOutlet weak var statusMessageLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


extension ProfileTableViewCell{
    
    // set Data to UIImageView and Labels
    func updateCell(pictureURLString: String?, userName: String?, statusMessage: String?, sumOfWillJoin: Int, sumOfJoined: Int){
        
        
        sumOfWillJoinLabel.text = String(sumOfWillJoin)
        sumOfJoinedLabel.text = String(sumOfJoined)
        if userName != nil {
            userNameLabel.text = userName
        }
        if statusMessage != nil {
            statusMessageLabel.text = statusMessage
        }
        if pictureURLString != nil {
            guard let pictureURL = URL(string: pictureURLString!) else {
                print("String to URL conversion failed")
                return
            }
            let task = URLSession.shared.dataTask(with: pictureURL){
                (data, response, error) in
                if let data = data {
                    DispatchQueue.main.async {
                        self.profileImageView.image = UIImage(data: data)
                    }
                }
            }
            task.resume()
        }
    }
}
