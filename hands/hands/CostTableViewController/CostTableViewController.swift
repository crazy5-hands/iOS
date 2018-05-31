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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let costNib = UINib(nibName: "CostListTableViewCell", bundle: nil)
        self.tableView.register(costNib, forCellReuseIdentifier: "cost")
        self.loadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cost.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cost") as! CostListTableViewCell
        let costDate = DateUtils().stringFromDate(date: self.cost[indexPath.row].created_at)
        cell.updateCell(title: costDate, cost: "\(cost[indexPath.row].cost)")
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(50)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)")
    }
    
    func startLoading() {
        
    }
    
    func endLoading() {
        
    }
    
    func loadData() {
        
    }
}
