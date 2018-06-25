//
//  NewGroupViewController.swift
//  hands
//
//  Created by 山浦功 on 2018/06/25.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import UIKit
import Firebase

class NewGroupViewController: TextFieldViewController {
    
    @IBOutlet weak private var nameTextField: DoneButtonTextField!
    @IBOutlet weak private var noteTextView: DoneButtonTextView!
    @IBOutlet weak private var statusOfPrivate: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpNotificationForTextField()
    }
    
    @IBAction func done(_ sender: Any) {
        let firestore = Firestore.firestore()
        let newGroupId = UUID().uuidString
        let name = self.nameTextField.text!
        let note = self.noteTextView.text!
        let statusOfPrivate = self.getStatus()
        let newGroup = Group(dictionary: ["id": newGroupId, "name": name, "note": note, "created_at": NSDate(), "privated": statusOfPrivate])!
        firestore.collection("group").document(newGroupId).setData(newGroup.dictionary)
    }
    
    private func getStatus() -> Bool {
        if self.statusOfPrivate.selectedSegmentIndex == 0 {
            return true
        } else {
            return false
        }
    }
}
