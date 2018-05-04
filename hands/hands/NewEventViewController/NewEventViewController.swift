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

    @IBOutlet weak var titleTextField: DoneButtonTextField!
    @IBOutlet weak var bodyTextView: DoneButtonTextView!
    private var viewModel: NewEventViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = NewEventViewModel()
    }
    
    @IBAction private func submit(_ sender: Any) {
        self.viewModel?.createNewEvent(title: self.titleTextField.text!, body: self.bodyTextView.text!, callback: { (result) in
            if result == true {
                self.dismiss(animated: true, completion: nil)
            }else {
                self.showAlert("新しいイベントの作成に失敗しました")
            }
        })
    }
//
//        let userId = Auth.auth().currentUser?.uid
//        self.ref.child(userId!).observe(.value, with: { snapshot in
//            let value = snapshot.value as? NSDictionary
//            let uid = value?["uid"] as? String
//            let username = value?["username"] as? String ?? ""
//
//            self.writeNewEvent(userID: uid!, author: username, title: self.titleTextField.text!, body: self.bodyTextView.text, create_at: "")
//            self.navigationController?.popViewController(animated: true)
//        }) { (error) in
//            print(error.localizedDescription)
//        }
//    }
    
//    private func writeNewEvent(userID: String, author: String, title: String, body: String, create_at: String) {
//        let key = self.ref.child("events").childByAutoId().key
//        let event = ["uid": userID,
//                    "author": author,
//                    "title": title,
//                    "body": body,
//                    "create_at": create_at]
//        let childUpdates = ["/events/\(key)": event,
//                            "/user-events/\(userID)/\(key)/": event]
//        ref.updateChildValues(childUpdates)
//    }
}
