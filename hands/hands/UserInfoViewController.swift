//
//  UserInfoViewController.swift
//  hands
//
//  Created by 山浦功 on 2018/01/25.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import UIKit
import LineSDK

class UserInfoViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var displayNameLabel: UILabel!
    @IBOutlet weak var userIdLabel: UILabel!
    @IBOutlet weak var statusMessageLabel: UILabel!
    
    
    var userData: Dictionary<String, String> = [ : ]
    var apiClinet: LineSDKAPI?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.apiClinet = LineSDKAPI(configuration: LineSDKConfiguration.defaultConfig())
        self.displayNameLabel.text = self.userData["displayname"]
        self.userIdLabel.text = self.userData["userid"]
        self.statusMessageLabel.text = self.userData["statusmessage"]
        
        guard let pictureURLString = self.userData["pictureurl"] else {
            print("picture URL is blank")
            return
        }
        
        guard let pictureURL = URL(string: pictureURLString) else {
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
