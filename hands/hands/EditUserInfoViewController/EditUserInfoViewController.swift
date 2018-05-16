//
//  EditUserInfoViewController.swift
//  hands
//
//  Created by 山浦功 on 2018/04/11.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import UIKit
import Firebase

class EditUserInfoViewController: TextFieldViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var displayNameTextField: UITextField!
    @IBOutlet private weak var submitButton: UIButton!
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    
    fileprivate var viewModel: EditUserInfoViewModel!
    fileprivate var activeTextField: UITextField?
    private let db = Firestore.firestore()
    private let photoSize = CGSize(width: 100, height: 100)
    private var photoURL: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.displayNameTextField.delegate = self
        self.imageView.addGestureRecognizer(.init(target: self, action: #selector(EditUserInfoViewController.imageTapped) ))
        DispatchQueue.global().async {
            self.viewModel = EditUserInfoViewModel(complition: { (result) in
                if result == true {
                    DispatchQueue.main.async {
                        let user = self.viewModel.getUser()
                        self.displayNameTextField.text = user?.username
                        self.imageView.image = self.viewModel.getPhoto()?.resize(size: self.photoSize)
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
        self.setUpNotificationForTextField()
    }
    
    @IBAction func submit(_ sender: Any) {
        self.viewModel.updateData(username: self.displayNameTextField.text!, photo: self.imageView.image, url: self.photoURL, handler: { result in
            if result == true {
                self.dismiss(animated: true, completion: nil)
            }else {
                showAlert("更新失敗")
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
        self.imageView.image = image.resize(size: photoSize)
        self.dismiss(animated: true, completion: nil)
    }
}
