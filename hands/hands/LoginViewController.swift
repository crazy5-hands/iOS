//
//  LoginViewController.swift
//  hands
//
//  Created by 山浦功 on 2018/01/22.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import UIKit
import LineSDK

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        LineSDKLogin.sharedInstance().delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension LoginViewController: LineSDKLoginDelegate{
    
    func didLogin(_ login: LineSDKLogin, credential: LineSDKCredential?, profile: LineSDKProfile?, error: Error?) {
        if error != nil {
            print(error.debugDescription)
        }
        
        if let accessToken = credential?.accessToken{
            print("accessToken : \(accessToken)")
        }
        
        if let displayName = profile?.displayName {
            print("displayName : \(displayName)")
        }
        
        if let userID = profile?.userID {
            print("userID : \(userID)")
        }
        
        if let pictureURL = profile?.pictureURL{
            print("picture  url: \(pictureURL)")
        }
    }
    
    
    
}
