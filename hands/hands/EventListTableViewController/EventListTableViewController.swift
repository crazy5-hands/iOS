//
//  EventListTableViewController.swift
//  hands
//
//  Created by 山浦功 on 2018/05/03.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import UIKit
import FirebaseAuth
class EventListTableViewController: UITableViewController {
    
    var id: String = (Auth.auth().currentUser?.uid)!
    var pattern: EventDataPattern = .all
    private var viewModel: EventListTableViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = EventListTableViewModel()
        DispatchQueue.global(qos: .userInitiated).async {
            self.viewModel.getEvents(id: self.id, dataPattern: self.pattern, complition: { (result) in
                if result == true {
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }else {
                    print("error to get Data")
                }
            })
        }
        self.tableView.estimatedRowHeight = 140
        self.tableView.rowHeight = UITableViewAutomaticDimension
        let nib = UINib(nibName: "EventTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "event")
        self.tableView.delegate = self
        self.tableView.dataSource = self
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
}
