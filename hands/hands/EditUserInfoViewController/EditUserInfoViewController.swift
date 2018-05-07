//
//  EditUserInfoViewController.swift
//  hands
//
//  Created by 山浦功 on 2018/04/11.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import RxSwift
import RxCocoa

class EditUserInfoViewController: TextFieldViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var displayNameTextField: UITextField!
    @IBOutlet private weak var submitButton: UIButton!
    
    fileprivate var viewModel: EditUserInfoViewModel!
    fileprivate let disposeBag = DisposeBag()
    fileprivate var activeTextField: UITextField?
    private let db = Firestore.firestore()
    private var photoURL: URL?
    private let photoSize = CGSize(width: 100, height: 100)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.displayNameTextField.delegate = self
        self.imageView.addGestureRecognizer(.init(target: self, action: #selector(EditUserInfoViewController.imageTapped) ))
        self.viewModel = EditUserInfoViewModel()
        setUpBind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let user = Auth.auth().currentUser
        
            imageView.image = self.viewModel.getPhoto()?.resize(size: photoSize)
//                getImageFromURL((user?.photoURL?.absoluteString)!)?.resize(size: photoSize)
        
        self.setUpNotificationForTextField()
        self.displayNameTextField.text = self.viewModel.user?.username
    }
    
    @IBAction func submit(_ sender: Any) {
        let username = self.displayNameTextField.text ?? self.viewModel.user?.username
        self.viewModel.updateData(username: username!, photo: self.imageView.image, url: self.photoURL, handler: { result in
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
    
    
    private func setUpBind() {
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
        let url = info[UIImagePickerControllerImageURL] as? URL
        self.photoURL = url
        self.imageView.image = image.resize(size: photoSize)
        self.dismiss(animated: true, completion: nil)
    }
}

//set textField's delegate
extension EditUserInfoViewController {
    
    fileprivate func getImageFromURL(_ stringURL: String) -> UIImage? {
        var image: UIImage?
        let url = URL(string: stringURL)
        let session = URLSession(configuration: .default)
        let downloadPhotoTask = session.dataTask(with: url!){ data, response, error in
            if error != nil {
                print(error?.localizedDescription ?? "error get Image URL")
            }else {
                image = UIImage(data: data!)
            }
        }
        downloadPhotoTask.resume()
        return image
    }
}
