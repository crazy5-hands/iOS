//
//  EventListTableViewController.swift
//  hands
//
//  Created by 山浦功 on 2018/05/03.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import UIKit

class EventListTableViewController: UITableViewController {
    
    var events: [Event] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.estimatedRowHeight = 140
        self.tableView.rowHeight = UITableViewAutomaticDimension
        let nib = UINib(nibName: "EventTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "event")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        let refresh = UIRefreshControl()
        refresh.attributedTitle = NSAttributedString(string: "読み込み中")
        refresh.tintColor = .gray
        refresh.addTarget(self, action: #selector(self.loadData), for: .valueChanged)
        self.tableView.addSubview(refresh)
        self.refreshControl = refresh
        self.loadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.endLoading()
    }
    
    func loadData() {
        self.startLoading()
        DispatchQueue.global(qos: .userInitiated).async {
            EventUtil().getEventsAll(complition: { (events) in
                self.events = self.orderByCreatedAt(events: events)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                    self.reloadData()
                })
            })
        }
    }
    
    func reloadData() {
        let rvents = self.events
        self.events = self.orderByCreatedAt(events: rvents)
        self.endLoading()
        self.tableView.reloadData()
    }
    
    func orderByCreatedAt(events: [Event]) -> [Event] {
        var rEvents = events
        rEvents.sort { (first, second) -> Bool in
            return first.created_at as Date > second.created_at as Date
        }
        return rEvents
    }
    
    func startLoading() {
        self.refreshControl?.beginRefreshing()
    }
    
    func endLoading() {
        self.refreshControl?.endRefreshing()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.events.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "event", for: indexPath) as! EventTableViewCell
        let event = self.events[indexPath.row]
        cell.updateCell(eventKey: event.id, title: event.title, body: event.body, createAt: event.created_at)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let event = self.events[indexPath.row]
        let eventDetailTVC = EventDetailTableViewController()
        eventDetailTVC.event = event
        self.navigationController?.pushViewController(eventDetailTVC, animated: true)
    }
}
