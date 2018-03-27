//
//  LoginViewController.swift
//  hands
//
//  Created by 山浦功 on 2018/01/22.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import UIKit
import LineSDK
import FBSDKCoreKit
import FBSDKLoginKit

class LoginViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        LineSDKLogin.sharedInstance().delegate = self
        let facebookLoginButton = FBSDKLoginButton()
        facebookLoginButton.center = self.view.center
        self.view.addSubview(facebookLoginButton)
        if let accessToken = FBSDKAccessToken.current(){
            print(accessToken.userID)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func didTapLogin(_ sender: Any) {
        LineSDKLogin.sharedInstance().start()
    }
}

extension LoginViewController: LineSDKLoginDelegate{
    
    func didLogin(_ login: LineSDKLogin, credential: LineSDKCredential?, profile: LineSDKProfile?, error: Error?) {
        if login.isAuthorized() == true {
            print("access ok")
        }else {
            print("access no")
        }
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
        
        let storyboard = UIStoryboard(name: "UserInfoViewController", bundle: nil)
        if let userInfoVC = storyboard.instantiateViewController(withIdentifier: "userInfoViewController") as? UserInfoViewController {
            var data = ["userid" : profile?.userID,
                        "displayname" : profile?.displayName,
                        "accesstoken" : credential?.accessToken?.accessToken]
            
            if let pictureURL = profile?.pictureURL {
                data["pictureurl"] = pictureURL.absoluteString
            }
            
            if let statusMessage = profile?.statusMessage {
                data["statusmessage"] = statusMessage
            }
            
            userInfoVC.userData = data as! Dictionary<String, String>
            self.present(userInfoVC, animated: true, completion: nil)
        }
    }
    
}
