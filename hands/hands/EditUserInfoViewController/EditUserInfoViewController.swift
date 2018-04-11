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

class EditUserInfoViewController: UIViewController {

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var displayNameTextField: UITextField!
    @IBOutlet private weak var submitButton: UIButton!
    
    private let viewModel = EditUserInfoViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpData()
    }
    
    func setUpData() {
        self.displayNameTextField.rx.text.orEmpty
            .bind(to: self.viewModel.displayName)
            .disposed(by: self.disposeBag)
        self.viewModel.shouldSubmit
            .bind(to: self.submitButton.rx.isEnabled)
            .disposed(by: self.disposeBag)
    }
    
}
