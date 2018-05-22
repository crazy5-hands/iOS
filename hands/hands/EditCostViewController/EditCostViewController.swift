//
//  EditCostViewController.swift
//  hands
//
//  Created by 山浦功 on 2018/05/21.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import UIKit

class EditCostViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet private weak var numberTextField: UITextField!
    var eventId: String? = nil
    private var viewModel: EditCostViewModel?
    private var activeTextField: UITextField? = nil
    private let notificationCenter = NotificationCenter.default
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.global(qos: .userInitiated).async {
            if let id = self.eventId {
                self.viewModel = EditCostViewModel(eventId: id) { (result) in
                    if result == true {
                        DispatchQueue.main.async {
                            self.numberTextField.text = "\(self.viewModel?.getCost)"
                        }
                    }
                }
            }
        }
        self.numberTextField.delegate = self
        self.numberTextField.keyboardType = .numberPad
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.notificationCenter.addObserver(self, selector: #selector(self.handleKeyboardWillShowNotification(_:)), name: .UIKeyboardWillShow, object: nil)
        self.notificationCenter.addObserver(self, selector: #selector(self.handleKeyboardWillHideNotification(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.notificationCenter.removeObserver(self)
    }
    
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func submit(_ sender: Any) {
        var number = 0
        if let text = self.numberTextField.text {
            number = Int(text)!
        }
        self.viewModel?.update(cost: number, complition: { (result) in
            if result == true {
                self.dismiss(animated: true, completion: nil)
            } else {
                self.showAlert("更新に失敗しました。")
            }
        })
    }
    
    @objc private func handleKeyboardWillShowNotification(_ notification: Notification) {
        let userInfo = notification.userInfo //この中にキーボードの情報がある
        let keyboardSize = (userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardY = self.view.frame.size.height - keyboardSize.height //画面全体の高さ - キーボードの高さ = キーボードが被らない高さ
        
        var editingY: CGFloat {
            return (self.activeTextField?.frame.origin.y)!
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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let invalidCharacters = CharacterSet(charactersIn: "0123456789").inverted
        return string.rangeOfCharacter(from: invalidCharacters, options: [], range:  string.startIndex ..< string.endIndex) == nil
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
}
