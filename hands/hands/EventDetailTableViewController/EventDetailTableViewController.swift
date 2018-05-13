//
//  EventDetailTableViewController.swift
//  hands
//
//  Created by 山浦功 on 2018/05/13.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import UIKit

class EventDetailTableViewController: UITableViewController {

    var event: Event?
    private let viewModel = EventDetailTableViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.estimatedRowHeight = 305
        self.tableView.rowHeight = UITableViewAutomaticDimension
        let eventNib = UINib(nibName: "EventDetailTableViewCell", bundle: nil)
        self.tableView.register(eventNib, forCellReuseIdentifier: "event")
        DispatchQueue.global(qos: .userInitiated).async {
            self.viewModel.getData(event: self.event!, complition: { (result) in
                if result == true {
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }else {
                    self.navigationItem.prompt = "イベントのデータの読み込みに失敗しました。"
                }
            })
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1 // event and join
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return 1
        }
        return self.viewModel.getJoinsCount()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "event") as! EventDetailTableViewCell
        cell.updateCell(event: self.viewModel.getEvent())
        return cell
    }
    
}
