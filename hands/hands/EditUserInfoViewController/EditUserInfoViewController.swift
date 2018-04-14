//
//  EditUserInfoViewController.swift
//  hands
//
//  Created by 山浦功 on 2018/04/11.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import UIKit
import FirebaseAuth
import RxSwift
import RxCocoa

class EditUserInfoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var displayNameTextField: UITextField!
    @IBOutlet private weak var submitButton: UIButton!
    
    fileprivate let viewModel = EditUserInfoViewModel()
    fileprivate let disposeBag = DisposeBag()
    fileprivate var activeTextField: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.displayNameTextField.delegate = self
        self.imageView.addGestureRecognizer(.init(target: self, action: #selector(EditUserInfoViewController.imageTapped) ))
        setUpData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let user = Auth.auth().currentUser
        if user?.photoURL != nil {
            imageView.image = getImageFromURL((user?.photoURL?.absoluteString)!)
        }
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(EditUserInfoViewController.handleKeyboardWillShowNotification(_:)), name: .UIKeyboardWillShow, object: nil)
        notificationCenter.addObserver(self, selector: #selector(EditUserInfoViewController.handleKeyboardWillHideNotification(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    @IBAction func submit(_ sender: Any) {
        if self.viewModel.update(image: self.imageView.image) == false {
            showAlert("プロフィールの更新に失敗しました。")
        }
    }
    
    private func setUpData() {
        self.displayNameTextField.rx.text.orEmpty
            .bind(to: self.viewModel.displayName)
            .disposed(by: self.disposeBag)
        self.viewModel.shouldSubmit
            .bind(to: self.submitButton.rx.isEnabled)
            .disposed(by: self.disposeBag)
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
        self.imageView.image = image
        self.dismiss(animated: true, completion: nil)
    }
}

//set textField's delegate
extension EditUserInfoViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.activeTextField = textField
        return true
    }
    
    @objc fileprivate func handleKeyboardWillShowNotification(_ notification: Notification) {
        let userInfo = notification.userInfo!
        let keyboardSize = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardY = self.view.frame.size.height - keyboardSize.height
        let editingTextFieldY: CGFloat = (self.activeTextField?.frame.origin.y)!
        
        if editingTextFieldY > keyboardY - 60 {
            UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveEaseIn, animations: {
                self.view.frame = CGRect(x: 0, y: self.view.frame.origin.y - (editingTextFieldY - (keyboardY - 60)), width: self.view.bounds.width , height: self.view.bounds.height)
            }, completion: nil)
        }
    }
    
    @objc fileprivate func handleKeyboardWillHideNotification(_ notification: Notification) {
        UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveEaseIn, animations: {
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        }, completion: nil)
    }
    
    func getImageFromURL(_ stringURL: String) -> UIImage? {
        var image: UIImage?
        let url = URL(string: stringURL)
        let session = URLSession(configuration: .default)
        let downloadPhotoTask = session.dataTask(with: url!){ data, response, error in
            if error != nil {
                print(error?.localizedDescription)
            }else {
                image = UIImage(data: data!)
            }
        }
        downloadPhotoTask.resume()
        return image
    }
}
