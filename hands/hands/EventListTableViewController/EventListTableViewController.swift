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
        self.tableView.estimatedRowHeight = 140
        self.tableView.rowHeight = UITableViewAutomaticDimension
        let nib = UINib(nibName: "EventTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "event")
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let queue = DispatchQueue(label: "eventViewModel getEvent")
        queue.sync {
            self.viewModel.getEvents(id: self.id, dataPattern: self.pattern, complition: { (result) in
                if result == false {
                    print("error tvc")
                }else {
                    self.tableView.reloadData()
                }
            })
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.events.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "event", for: indexPath) as! EventTableViewCell
//        cell.photoImageView.image
        cell.titleLabel.text = self.viewModel.events[indexPath.row].title
        cell.bodyLabel.text = self.viewModel.events[indexPath.row].body
        cell.createAtLabel.text = DateUtils.stringFromDate(date: self.viewModel.events[indexPath.row].created_at)
        return cell
    }
}
