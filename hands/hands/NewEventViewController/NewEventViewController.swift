//
//  NewEventViewController.swift
//  hands
//
//  Created by 山浦功 on 2018/04/28.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import UIKit
import Firebase

class NewEventViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {

    @IBOutlet weak var titleTextField: DoneButtonTextField!
    @IBOutlet weak var bodyTextView: DoneButtonTextView!
    private var viewModel: NewEventViewModel?
    fileprivate var activeTextField: UITextField?
    fileprivate var activeTextView: UITextView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = NewEventViewModel()
        self.titleTextField.delegate = self
        self.bodyTextView.delegate = self
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(self.close))

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(self.handleKeyboardWillShowNotification(_:)), name: .UIKeyboardWillShow, object: nil)
        notificationCenter.addObserver(self, selector: #selector(self.handleKeyboardWillHideNotification(_:)), name: .UIKeyboardWillHide, object: nil)
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
    
    func close() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func handleKeyboardWillShowNotification(_ notification: Notification) {
        let userInfo = notification.userInfo //この中にキーボードの情報がある
        let keyboardSize = (userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardY = self.view.frame.size.height - keyboardSize.height //画面全体の高さ - キーボードの高さ = キーボードが被らない高さ
        
        var editingY: CGFloat {
            if self.activeTextField != nil {
                return (self.activeTextField?.frame.origin.y)!
            }else {
                return (self.activeTextView?.frame.origin.y)!
            }
        }
        if editingY > keyboardY - 60 {
            UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveEaseIn, animations: {
                self.view.frame = CGRect(x: 0, y: self.view.frame.origin.y - (editingY - (keyboardY - 60)), width: self.view.bounds.width, height: self.view.bounds.height)
            }, completion: nil)
            
        }
    }
    
    @objc private func handleKeyboardWillHideNotification(_ notification: Notification) {
        UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveEaseIn, animations: {
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        }, completion: nil)
    }
    
    //textfield
    internal func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.activeTextField = textField
        return true
    }
    
    internal func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.activeTextField = nil
        textField.resignFirstResponder()
        return true
    }
    
    //textview
    internal func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        self.activeTextView = textView
        return true
    }
    
    internal func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        self.activeTextView = nil
        textView.resignFirstResponder()
        return true
    }
}
