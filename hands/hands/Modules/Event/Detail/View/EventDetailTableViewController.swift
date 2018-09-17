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
    private let kSectionCost = 3
    private let kSectionDelete = 4
    private let viewModel = EventDetailTableViewModel()
    private var activityIndicator: UIActivityIndicatorView!
    var presenter: EventDetailPresenterInterface?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.viewDidLoad()
        self.tableView.estimatedRowHeight = 305
        self.tableView.rowHeight = UITableViewAutomaticDimension
        let eventNib = UINib(nibName: "EventDetailTableViewCell", bundle: nil)
        let userNib = UINib(nibName: "UserTableViewCell", bundle: nil)
        let costNib = UINib(nibName: "CostTableViewCell", bundle: nil)
        let deleteNib = UINib(nibName: "DeleteTableViewCell", bundle: nil)
        self.tableView.register(eventNib, forCellReuseIdentifier: "event")
        self.tableView.register(userNib, forCellReuseIdentifier: "user")
        self.tableView.register(costNib, forCellReuseIdentifier: "cost")
        self.tableView.register(deleteNib, forCellReuseIdentifier: "delete")
        self.activityIndicator = UIActivityIndicatorView()
        self.activityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        self.activityIndicator.center = self.view.center
        self.activityIndicator.hidesWhenStopped = true
        self.activityIndicator.activityIndicatorViewStyle = .gray
        self.view.addSubview(self.activityIndicator)
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
                        self.tableView.reloadData()
                    }
                }else {
                    self.navigationItem.prompt = "イベントのデータの読み込みに失敗しました。"
                }
            })
        }
    }
    
    func startLoading() {
        self.activityIndicator.startAnimating()
    }
    
    func endLoading() {
        self.activityIndicator.stopAnimating()
    }
    
    func deleteEvent() {
        self.startLoading()
        DispatchQueue.global(qos: .userInitiated).async {
            let group = DispatchGroup()
            var eventResult = false
            var costResult = false
            if let event = self.event {
                group.enter()
                EventUtil().delete(target: event, complition: { (result) in
                    eventResult = result
                    group.leave()
                })
                
                group.enter()
                self.deleteCost(event: event, complition: { (result) in
                    costResult = result
                    group.leave()
                })
                group.notify(queue: .main, execute: {
                    sleep(1)
                    self.endLoading()
                    if eventResult == true && costResult == true {
                        self.navigationController?.popViewController(animated: true)
                    } else {
                        self.showAlert("削除に失敗しました。")
                    }
                })
            }
        }
    }
    
    func deleteCost(event: Event, complition: @escaping (Bool) -> Void) {
        CostUtil().getCostByEventId(eventId: event.id) { (cost) in
            if let cost = cost {
                CostUtil().destroy(target: cost, complition: { (result) in
                    complition(result)
                })
            } else {
                complition(true)
            }
        }
    }
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 5 // event and join
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case kSectionEvent:
            return 1
        case kSectionAuthor:
            return 1
        case kSectionJoin:
            return self.viewModel.getJoinsCount()
        case kSectionCost:
            return 1
        case kSectionDelete:
            return 1
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
        case kSectionCost:
            return "料金"
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
        case kSectionCost:
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
        case kSectionCost:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cost") as! CostTableViewCell
            cell.update(cost: self.viewModel.getCost())
            cell.selectionStyle = .none
            return cell
        case kSectionDelete:
            let cell = tableView.dequeueReusableCell(withIdentifier: "delete") as! DeleteTableViewCell
            cell.selectionStyle = .none
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case kSectionAuthor:
            let next = UserDetailTableViewController()
            next.userId = self.viewModel.getEvent().author_id
            if next.userId != nil {
                self.navigationController?.pushViewController(next, animated: true)
            }
        case kSectionJoin:
            let next = UserDetailTableViewController()
            next.userId = self.viewModel.getJoinerById(number: indexPath.item).id
            self.navigationController?.pushViewController(next, animated: true)
        case kSectionDelete:
            let alert: UIAlertController = UIAlertController(title: "イベントの削除", message: "本当にイベントの削除をしていいですか？", preferredStyle: .actionSheet)
            let deleteAction: UIAlertAction = UIAlertAction(title: "削除", style: .destructive) { (alertAction) in
                self.deleteEvent()
            }
            let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
            alert.addAction(cancelAction)
            alert.addAction(deleteAction)
            present(alert, animated: true, completion: nil)
        default:
            break
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case kSectionEvent:
            return UITableViewAutomaticDimension
        case kSectionAuthor:
            return 50.0
        case kSectionJoin:
            return 50.0
        case kSectionCost:
            return 170.0
        case kSectionDelete:
            return 60
        default:
            return CGFloat()
        }
    }
}

extension EventDetailTableViewController: EventDetailViewInterface {}

extension EventDetailTableViewController: StoryboardLoadable {

    static var storyboardName: String {
        return Storyboard.eventDetailViewController.name
    }
}
