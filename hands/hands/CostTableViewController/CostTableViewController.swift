//
//  CostTableViewController.swift
//  hands
//
//  Created by 山浦功 on 2018/05/31.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import UIKit

class CostTableViewController: UITableViewController {
    
    var cost: [Cost] = []
    var event: [Event] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .black
        refreshControl.attributedTitle = NSAttributedString(string: "更新中")
        refreshControl.addTarget(self, action: #selector(self.loadData), for: .valueChanged)
        self.tableView.addSubview(refreshControl)
        self.refreshControl = refreshControl
        let costNib = UINib(nibName: "CostListTableViewCell", bundle: nil)
        self.tableView.register(costNib, forCellReuseIdentifier: "cost")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadData()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cost.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cost") as! CostListTableViewCell
        let title = self.event[indexPath.row].title
        let cost = self.cost[indexPath.row].cost
        cell.updateCell(title: title, cost: cost)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(50)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)")
    }
    
    func startLoading() {
        self.refreshControl?.beginRefreshing()
    }
    
    func endLoading() {
        self.refreshControl?.endRefreshing()
    }
    
    @objc func loadData() {
    }
}
