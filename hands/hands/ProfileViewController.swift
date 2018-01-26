//
//  ProfileViewController.swift
//  hands
//
//  Created by 山浦功 on 2018/01/25.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import UIKit
import LineSDK

class ProfileViewController: UIViewController {

    var apiCliant: LineSDKAPI?
    
    @IBOutlet weak var displayNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.apiCliant = LineSDKAPI(configuration: LineSDKConfiguration.defaultConfig())
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
