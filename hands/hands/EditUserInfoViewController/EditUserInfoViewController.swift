//
//  EditUserInfoViewController.swift
//  hands
//
//  Created by 山浦功 on 2018/04/11.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import UIKit
import Firebase

class EditUserInfoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UITextViewDelegate {

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var displayNameTextField: DoneButtonTextField!
    @IBOutlet weak var noteTextView: DoneButtonTextView!
    @IBOutlet private weak var submitButton: UIButton!
    @IBOutlet weak var navigationBar: UINavigationBar!
    fileprivate var activeTextField: UITextField?
    fileprivate var activeTextView: UITextView?
    
    
    fileprivate var viewModel: EditUserInfoViewModel!
    private let db = Firestore.firestore()
    private let photoSize = CGSize(width: 100, height: 100)
    private var photoURL: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.displayNameTextField.delegate = self
        self.noteTextView.delegate = self
        self.imageView.addGestureRecognizer(.init(target: self, action: #selector(EditUserInfoViewController.imageTapped) ))
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(self.handleKeyboardWillShowNotification(_:)), name: .UIKeyboardWillShow, object: nil)
        notificationCenter.addObserver(self, selector: #selector(self.handleKeyboardWillHideNotification(_:)), name: .UIKeyboardWillHide, object: nil)
        DispatchQueue.global().async {
            self.viewModel = EditUserInfoViewModel(complition: { (result) in
                if result == true {
                    DispatchQueue.main.async {
                        let user = self.viewModel.getUser()
                        self.displayNameTextField.text = user?.username
                        self.imageView.image = self.viewModel.getPhoto()?.resize(size: self.photoSize)
                        self.noteTextView.text = user?.note
                    }
                }else {
                    DispatchQueue.main.async {
                        self.imageView.image = self.viewModel.getPhoto()?.resize(size: self.photoSize)
                    }
                }
            })
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func submit(_ sender: Any) {
        self.viewModel.updateData(username: self.displayNameTextField.text!, note: self.noteTextView.text!, photo: self.imageView.image, imageURL: photoURL, handler: { result in
            if result == true {
                self.dismiss(animated: true, completion: nil)
            }else {
                self.showAlert("更新失敗")
            }
        })
    }
    
    @IBAction func changeImage(_ sender: Any) {
        let imagePickerViewController = UIImagePickerController()
        imagePickerViewController.delegate = self
        self.present(imagePickerViewController, animated: true, completion: nil)
    }
    
    
    @IBAction func dismissThisView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func imageTapped() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let pickerView = UIImagePickerController()
            pickerView.sourceType = .photoLibrary
            pickerView.delegate = self
            self.present(pickerView, animated: true, completion: nil)
        }
    }
    
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        let url = info[UIImagePickerControllerImageURL] as? URL
        self.photoURL = url
        self.imageView.image = image
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
