//
//  PrivacyPolicyViewController.swift
//  hands
//
//  Created by 山浦功 on 2018/05/29.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class PrivacyPolicyViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var acceptPrivacyPolicyButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    private let viewModel = PrivacyPolicyViewModel()
    private let disposeBag = DisposeBag()
    private var agreed = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let requestURL = URL(fileURLWithPath: "https://crazy5-hands.github.io/hands.github.io/")
        let request = URLRequest(url: requestURL)
        self.webView.loadRequest(request)
    }
    
    private func setUpBind() {
        
        self.viewModel.acceptPrivacyPolocy
            .bind(to: self.nextButton.rx.isEnabled)
            .disposed(by: self.disposeBag)
    }
    
    @IBAction func checkedAgree(_ sender: Any) {
        if self.agreed == false {
            self.agreed = true
            self.acceptPrivacyPolicyButton.setImage(#imageLiteral(resourceName: "checkboxChecked"), for: .normal)
            self.nextButton.isEnabled = true
        } else {
            self.agreed = false
            self.acceptPrivacyPolicyButton.setImage(#imageLiteral(resourceName: "checkboxEmpty"), for: .normal)
            self.nextButton.isEnabled = false
        }
        
    }
    
    @IBAction func next(_ sender: Any) {
        //segue to next
        self.segueToEditUserInfo()
    }
    
    private func segueToEditUserInfo() {
        let inital = UIStoryboard(name: "EditUserInfoViewController", bundle: nil).instantiateInitialViewController()
        self.present(inital!, animated: true, completion: nil)
    }
}
