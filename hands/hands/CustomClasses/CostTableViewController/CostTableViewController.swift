//
//  CostTableViewController.swift
//  hands
//
//  Created by 山浦功 on 2018/05/31.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import UIKit

class CostTableViewController: UITableViewController {
    
    var costs: [Cost] = []
    var events: [Event] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .black
        refreshControl.attributedTitle = NSAttributedString(string: "更新中")
        refreshControl.addTarget(self, action: #selector(self.loadData), for: .valueChanged)
        self.tableView.addSubview(refreshControl)
        self.refreshControl = refreshControl
        let costNib = UINib(nibName: "CostListTableViewCell", bundle: nil)
        let sumNib = UINib(nibName: "CostTableViewCell", bundle: nil)
        self.tableView.register(costNib, forCellReuseIdentifier: "cost")
        self.tableView.register(sumNib, forCellReuseIdentifier: "sum")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.endLoading()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.costs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cost") as! CostListTableViewCell
        cell.selectionStyle = .none
        let title = self.events[indexPath.row].title
        let cost =  self.costs[indexPath.row].cost
        cell.updateCell(title: title, cost: String(cost) + "円")
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(55)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = self.tableView.dequeueReusableCell(withIdentifier: "sum") as! CostTableViewCell
        var sum = 0
        for cost in self.costs {
            sum += cost.cost
        }
        headerCell.updateCell(title: "合計金額", cost: sum)
        let headerView = headerCell.contentView
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(100)
    }
    
    func startLoading() {
        self.refreshControl?.beginRefreshing()
    }
    
    func endLoading() {
        self.refreshControl?.endRefreshing()
    }
    
    /// get data of events and costs
    /// if it ready to show in tableview, stop refreshControl and reload tableview
    /// if it has no data, notice it to user with using navigation prompt
    @objc func loadData() {
    }
    
    func sortCostsByDate(costs: [Cost]) -> [Cost] {
        var rCosts = costs
        rCosts.sort { (first, second) -> Bool in
            return first.created_at as Date > second.created_at as Date
        }
        return rCosts
    }
    
    func sortEventsByDate(events: [Event]) -> [Event] {
        var rEvents = events
        rEvents.sort { (first, second) -> Bool in
            return first.created_at as Date > second.created_at as Date
        }
        return rEvents
    }
}
