//
//  ProfileTableViewController.swift
//  hands
//
//  Created by 山浦功 on 2018/05/22.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import UIKit
import FirebaseAuth

class ProfileTableViewController: UITableViewController {

    private let kSectionUserDetail = 0
    private let kSectionOwn = 1
    private let kSectionJoin = 2
    private let kSectionFollow = 3
    private let kSectionFollower = 4
    private let kSectionCost = 5
    private let kSectionPrivacyPolicy = 6
    private let kSectionUpdateEmail = 7
    private let kSectionUpdatePassword = 8
    private let kSectionLogout = 9
    private var viewModel = ProfileViewModel()
    private var indicatorView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let userDetailNib = UINib(nibName: "UserDetailTableViewCell", bundle: nil)
        let followNib = UINib(nibName: "FollowCountTableViewCell", bundle: nil)
        let costNib = UINib(nibName: "CostTableViewCell", bundle: nil)
        let deleteNib = UINib(nibName: "DeleteTableViewCell", bundle: nil)
        let titleNib = UINib(nibName: "TitleTableViewCell", bundle: nil)
        self.tableView.register(userDetailNib, forCellReuseIdentifier: "userDetail")
        self.tableView.register(followNib, forCellReuseIdentifier: "follow")
        self.tableView.register(costNib, forCellReuseIdentifier: "cost")
        self.tableView.register(deleteNib, forCellReuseIdentifier: "delete")
        self.tableView.register(titleNib, forCellReuseIdentifier: "title")
        self.indicatorView = UIActivityIndicatorView()
        self.indicatorView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        self.indicatorView.center = self.view.center
        self.indicatorView.hidesWhenStopped = true
        self.indicatorView.activityIndicatorViewStyle = .gray
        self.view.addSubview(self.indicatorView)
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .black
        refreshControl.attributedTitle = NSAttributedString(string: "読み込み中")
        refreshControl.addTarget(self, action: #selector(self.loadData), for: .valueChanged)
        self.tableView.addSubview(refreshControl)
        self.refreshControl = refreshControl
        self.loadData()
    }
    
    func loadData() {
        self.startLoading()
        DispatchQueue.global(qos: .userInitiated).async {
            self.viewModel.loadData(complition: { (result) in
                if result == true {
                    DispatchQueue.main.async {
                        self.endLaoding()
                        self.tableView.reloadData()
                    }
                } else {
                    DispatchQueue.main.async {
                        self.endLaoding()
                        self.navigationItem.prompt = "データの取得ができませんでした。"
                    }
                }
            })
        }
    }
    
    func startLoading() {
        self.refreshControl?.beginRefreshing()
    }
    
    func endLaoding() {
        self.refreshControl?.endRefreshing()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case kSectionUserDetail:
            return UITableViewAutomaticDimension
        default:
            return 50
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case kSectionUserDetail:
            let cell = tableView.dequeueReusableCell(withIdentifier: "userDetail") as! UserDetailTableViewCell
            cell.selectionStyle = .none
            if let user = self.viewModel.getUser() {
                cell.updateCell(user: user)
            }
            return cell
        case kSectionOwn:
            let cell = tableView.dequeueReusableCell(withIdentifier: "follow") as! FollowCountTableViewCell
            cell.updateCell(title: "投稿イベント", count: (self.viewModel.getOwnsCount()))
            return cell
        case kSectionJoin:
            let cell = tableView.dequeueReusableCell(withIdentifier: "follow") as! FollowCountTableViewCell
            cell.updateCell(title: "参加イベント", count: (self.viewModel.getJoinsCount()))
            return cell
        case kSectionFollow:
            let cell = tableView.dequeueReusableCell(withIdentifier: "follow") as! FollowCountTableViewCell
            cell.updateCell(title: "フォロー", count: (self.viewModel.getFollowsCount()))
            return cell
        case kSectionFollower:
            let cell = tableView.dequeueReusableCell(withIdentifier: "follow") as! FollowCountTableViewCell
            cell.updateCell(title: "フォロワー", count: (self.viewModel.getFollowersCount()))
            return cell
        case kSectionCost:
            let cell = tableView.dequeueReusableCell(withIdentifier: "title") as! TitleTableViewCell
            cell.updateCell(title: "イベントのコスト一覧")
            cell.accessoryType = .disclosureIndicator
            return cell
        case kSectionPrivacyPolicy:
            let cell = tableView.dequeueReusableCell(withIdentifier: "title") as! TitleTableViewCell
            cell.selectionStyle = .none
            cell.updateCell(title: "プライバシーポリシー")
            return cell
        case kSectionUpdateEmail:
            let cell = tableView.dequeueReusableCell(withIdentifier: "title") as! TitleTableViewCell
            cell.selectionStyle = .none
            cell.updateCell(title: "メールアドレスの再設定")
            return cell
        case kSectionUpdatePassword:
            let cell = tableView.dequeueReusableCell(withIdentifier: "title") as! TitleTableViewCell
            cell.selectionStyle = .none
            cell.updateCell(title: "パスワードの再設定")
            return cell
        case kSectionLogout:
            let cell = tableView.dequeueReusableCell(withIdentifier: "delete") as! DeleteTableViewCell
            cell.updateCell(title: "ログアウト")
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case kSectionOwn:
            let next = OwnEventListTableViewController()
            if let id = self.viewModel.getUser()?.id {
                next.userId = id
                self.navigationController?.pushViewController(next, animated: true)
            }
        case kSectionJoin:
            let next = JoinEventListTableViewController()
            if let id = self.viewModel.getUser()?.id {
                next.userId = id
                self.navigationController?.pushViewController(next, animated: true)
            }
        case kSectionFollow:
            let next = FollowListTableViewController()
            next.userId = self.viewModel.getUser()?.id
            self.navigationController?.pushViewController(next, animated: true)
        case kSectionFollower:
            let next = FollowerListTableViewController()
            next.userId = self.viewModel.getUser()?.id
            self.navigationController?.pushViewController(next, animated: true)
        case kSectionCost:
            let next = MyCostTableViewController()
            self.navigationController?.pushViewController(next, animated: true)
        case kSectionPrivacyPolicy:
            let url = URL(string: "https://crazy5-hands.github.io/hands.github.io/")
            if UIApplication.shared.canOpenURL(url!) {
                UIApplication.shared.open(url!, options: [:], completionHandler: nil)
            }
        case kSectionUpdateEmail:
            let next = UIStoryboard(name: "EmailViewController", bundle: nil).instantiateInitialViewController() as! EmailViewController
            self.present(next, animated: true, completion: nil)
        case kSectionUpdatePassword:
            let next = UIStoryboard(name: "PasswordViewController", bundle: nil).instantiateInitialViewController() as! PasswordViewController
            self.present(next, animated: true, completion: nil)
        case kSectionLogout:
            let alert = UIAlertController(title: "ログアウト", message: "本当にログアウトしますか", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
            let logoutAction = UIAlertAction(title: "ログアウト", style: .destructive) { (alert) in
                self.indicatorView.startAnimating()
                if Auth.auth().currentUser != nil {
                    do {
                        try Auth.auth().signOut()
                        self.indicatorView.stopAnimating()
                    }
                    catch {
                        self.showAlert(error.localizedDescription)
                    }
                }
                if Auth.auth().currentUser == nil {
                    let next = UIStoryboard(name: "LoginViewController", bundle: nil).instantiateInitialViewController()
                    self.present(next!, animated: false, completion: nil)
                } else {
                    self.showAlert("ログアウトに失敗しました。")
                }
            }
            alert.addAction(logoutAction)
            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
        default:
            break
        }
    }
}
