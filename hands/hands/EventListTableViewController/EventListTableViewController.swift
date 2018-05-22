//
//  EventListTableViewController.swift
//  hands
//
//  Created by 山浦功 on 2018/05/03.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import UIKit

class EventListTableViewController: UITableViewController {
    
    var eventIds: [String] = []
    private var viewModel: EventListTableViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = EventListTableViewModel()
        self.tableView.estimatedRowHeight = 140
        self.tableView.rowHeight = UITableViewAutomaticDimension
        let nib = UINib(nibName: "EventTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "event")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        let refresh = UIRefreshControl()
        refresh.attributedTitle = NSAttributedString(string: "読み込み中")
        refresh.tintColor = .gray
        refresh.addTarget(self, action: #selector(self.refreshData), for: .valueChanged)
        self.tableView.addSubview(refresh)
        self.refreshControl = refresh
        self.loadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.refreshControl?.endRefreshing()
    }
    
    @objc private func refreshData() {
        self.refreshControl?.beginRefreshing()
        self.loadData()
    }
    
    private func loadData() {
        DispatchQueue.global(qos: .userInitiated).async {
            self.viewModel.getEventsByEventIds(eventIds: self.getEventIDs(), complition: { (result) in
                if result == true {
                    DispatchQueue.main.async {
                        self.refreshControl?.endRefreshing()
                        sleep(1)
                        self.tableView.reloadData()
                    }
                } else {
                    DispatchQueue.main.async {
                        self.refreshControl?.endRefreshing()
                        sleep(1)
                        self.navigationItem.prompt = "データが取得できませんでした。"
                    }
                }
            })
        }
    }
    
    func getEventIDs() -> [String] {
        return self.eventIds
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.getEventCount()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "event", for: indexPath) as! EventTableViewCell
        let event = self.viewModel.getEventByNumber(number: indexPath.row)
        cell.updateCell(eventKey: event.id, title: event.title, body: event.body, createAt: event.created_at)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let event = self.viewModel.getEventByNumber(number: indexPath.item)
        let eventDetailTVC = EventDetailTableViewController()
        eventDetailTVC.event = event
        self.navigationController?.pushViewController(eventDetailTVC, animated: true)
    }
}
