//
//  NewEventViewController.swift
//  hands
//
//  Created by 山浦功 on 2018/04/28.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import UIKit
import Firebase

class NewEventViewController: TextFieldViewController {

    private var ref: DatabaseReference!
    @IBOutlet private weak var titleTextField: UITextField!
    @IBOutlet private weak var bodyTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ref = Database.database().reference()
    }
    
    @IBAction private func submit(_ sender: Any) {
        let userId = Auth.auth().currentUser?.uid
        self.ref.child(userId!).observe(.value, with: { snapshot in
            let value = snapshot.value as? NSDictionary
            let uid = value?["uid"] as? String
            let username = value?["username"] as? String ?? ""
            
            self.writeNewEvent(userID: uid!, author: username, title: self.titleTextField.text!, body: self.bodyTextView.text, create_at: "")
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    private func writeNewEvent(userID: String, author: String, title: String, body: String, create_at: String) {
        let key = self.ref.child("events").childByAutoId().key
        let post = ["uid": userID,
                    "author": author,
                    "title": title,
                    "body": body,
                    "create_at": create_at]
        let childUpdates = ["/posts/\(key)": post,
                            "/user-posts/\(userID)/\(key)/": post]
        ref.updateChildValues(childUpdates)
    }
}
