//
//  EventDetailTableViewController.swift
//  hands
//
//  Created by 山浦功 on 2018/05/13.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import UIKit
import Firebase

class EventDetailTableViewController: UITableViewController {

    var event: Event?
    private let kSectionEvent = 0
    private let kSectionAuthor = 1
    private let kSectionJoin = 2
    private let viewModel = EventDetailTableViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.estimatedRowHeight = 305
        self.tableView.rowHeight = UITableViewAutomaticDimension
        let eventNib = UINib(nibName: "EventDetailTableViewCell", bundle: nil)
        let userNib = UINib(nibName: "UserTableViewCell", bundle: nil)
        self.tableView.register(eventNib, forCellReuseIdentifier: "event")
        self.tableView.register(userNib, forCellReuseIdentifier: "user")
        self.loadData()
    }
    
    @objc private func joinThisEvent() {
        self.viewModel.createJoin { (result) in
            if result == true {
                self.navigationItem.prompt = "参加しました"
                self.loadData()
            }else {
                self.showAlert("参加できません。")
            }
        }
//        let id = NSUUID().uuidString
//        let eventId = self.viewModel.getEvent().id
//        let uid = Auth.auth().currentUser?.uid
//        let createAt = NSDate()
//        let newJoin = Join(id: id, event_id: eventId, user_id: uid!, created_at: createAt)
//        JoinUtil().createNewJoin(join: newJoin) { (result) in
//            if result == true { // success
//                self.showAlert("成功")
//            } else {
//                self.showAlert("失敗")
//            }
//        }
    }
    
    private func loadData() {
        DispatchQueue.global(qos: .userInitiated).async {
            self.viewModel.getData(event: self.event!, complition: { (result) in
                if result == true {
                    DispatchQueue.main.async {
                        if self.viewModel.isAuthorMe() != true {
                            if self.viewModel.isAlreadyJoin() != true  {
                                self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "参加する", style: .done, target: self, action: #selector(self.joinThisEvent))
                            }
                        }
                        print(self.viewModel.getJoinsCount())
                        self.tableView.reloadData()
                    }
                }else {
                    self.navigationItem.prompt = "イベントのデータの読み込みに失敗しました。"
                }
            })
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3 // event and join
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case kSectionEvent:
            return 1
        case kSectionAuthor:
            return 1
        case kSectionJoin:
            return self.viewModel.getJoinsCount()
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case kSectionEvent:
            return ""
        case kSectionAuthor:
            return "投稿者"
        case kSectionJoin:
            return "参加者"
        default:
            return ""
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case kSectionEvent:
            return CGFloat(0.0)
        case kSectionAuthor:
            return CGFloat(25)
        case kSectionJoin:
            return CGFloat(25)
        default:
            return CGFloat(0.0)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case kSectionEvent:
            let cell = tableView.dequeueReusableCell(withIdentifier: "event") as! EventDetailTableViewCell
            cell.updateCell(event: self.viewModel.getEvent())
            cell.selectionStyle  = .none
            return cell
        case kSectionAuthor:
            let cell = tableView.dequeueReusableCell(withIdentifier: "user") as! UserTableViewCell
            if let author = self.viewModel.getAuthor() {
                cell.updateCell(user: author)
            }
            return cell
        case kSectionJoin:
            let cell = tableView.dequeueReusableCell(withIdentifier: "user") as! UserTableViewCell
            cell.updateCell(user: self.viewModel.getJoinerById(number: indexPath.item))
            return cell
        default:
            return UITableViewCell()
        }
    }
}
