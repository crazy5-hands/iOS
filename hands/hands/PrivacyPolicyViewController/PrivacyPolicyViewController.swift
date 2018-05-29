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

class PrivacyPolicyViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var acceptPrivacyPolicyButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    private let viewModel = PrivacyPolicyViewModel()
    private let disposeBag = DisposeBag()
    private var agreed = false
    private let activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.activityIndicator.tintColor = .black
        self.activityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        self.activityIndicator.center = self.view.center
        self.activityIndicator.hidesWhenStopped = true
        self.activityIndicator.activityIndicatorViewStyle = .gray
        self.view.addSubview(self.activityIndicator)
        let requestURL = URL(string: "https://crazy5-hands.github.io/hands.github.io/")
        let request = URLRequest(url: requestURL!)
        self.webView.loadRequest(request)
    }
    
    private func setUpBind() {
        
        self.viewModel.acceptPrivacyPolocy
            .bind(to: self.nextButton.rx.isEnabled)
            .disposed(by: self.disposeBag)
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        self.activityIndicator.stopAnimating()
        self.activityIndicator.isHidden = true
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        self.activityIndicator.stopAnimating()
        self.activityIndicator.isHidden = true
    }
    
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
