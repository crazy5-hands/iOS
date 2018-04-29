//
//  ListDetailTableViewController.swift
//  hands
//
//  Created by 山浦功 on 2018/04/29.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import UIKit
import Firebase

class ListDetailTableViewController: UITableViewController {

    private let kSectionEvent = 0
    private let kSectionJoiner = 1
    private let joiner = [String: Bool]()
    private var eventRef: DatabaseReference!
    private var eventKey = ""
    lazy var ref = Database.database().reference()
    private var event = Event()
    private var refHandle: DatabaseHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.eventRef = ref.child("events").child(eventKey)
        let nib = UINib(nibName: "EventTableViewCell", bundle: nil)
        let nibUser = UINib(nibName: "UserTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "event")
        self.tableView.register(nibUser, forCellReuseIdentifier: "joiner")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.refHandle = eventRef.observe(DataEventType.value, with: { (snapshot) in
            let eventDict = snapshot.value as? [String: AnyObject] ?? [:]
            self.event.setValuesForKeys(eventDict)
            self.tableView.reloadData()
            self.navigationItem.title = self.event.title
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let refHandle = self.refHandle {
            self.eventRef.removeObserver(withHandle: refHandle)
        }
        
        // Is this need??  ↓
        if let uid = Auth.auth().currentUser?.uid {
            Database.database().reference().child("users").child(uid).removeAllObservers()
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case kSectionEvent:
            return 1
        case kSectionJoiner:
            return self.joiner.count
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == kSectionEvent {
            return 200
        }
        return 50
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        switch indexPath.section {
        case kSectionEvent:
            cell = tableView.dequeueReusableCell(withIdentifier: "event")!
            if let uid = Auth.auth().currentUser?.uid {
                guard let eventCell = cell as? EventTableViewCell else { break }
                eventCell.updateCell(eventKey: self.event.eventId, title: self.event.title, body: self.event.body, createAt: self.event.create_at)
            }
        case kSectionJoiner:
            cell = tableView.dequeueReusableCell(withIdentifier: "joiner") as! UserTableViewCell
            if let uid = Auth.auth().currentUser?.uid {
                guard let userCell = cell as? UserTableViewCell else { break }
//                userCell.updateCell(image: self.event.joiner, name: <#T##String#>)
            }
        default:
            cell = tableView.dequeueReusableCell(withIdentifier: "none")!
        }
        
        return cell
    }
}
