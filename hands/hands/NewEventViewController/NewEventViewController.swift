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
}
