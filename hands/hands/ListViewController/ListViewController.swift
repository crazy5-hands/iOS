//
//  ListViewController.swift
//  hands
//
//  Created by 山浦功 on 2018/04/26.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabaseUI

class ListViewController: UIViewController, UITableViewDelegate {

    var ref: DatabaseReference!
    
    var dataSource: FUITableViewDataSource?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ref = Database.database().reference()
        
        let identifier = "event"
        let nib = UINib(nibName: "EventTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: identifier)
        
        dataSource = FUITableViewDataSource(query: getQuery(), populateCell: { (tableView, indexPath, snapShot) -> UITableViewCell in
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! EventTableViewCell
//            guard let event = Event(snapchat: snapShot) else {return cell }
//            cell.updateCell(eventKey: event.eventId, title: event.title, body: event.body, createAt: event.create_at)
            return cell
        })
        
        dataSource?.bind(to: self.tableView)
        self.tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.getQuery().removeAllObservers()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //write performance segue
    }
    
    func getUid() -> String {
        return (Auth.auth().currentUser?.uid)!
    }
    
    func getQuery() -> DatabaseQuery {
        let recentEventQuery = self.ref.child("events").queryLimited(toFirst: 100)
        return recentEventQuery
    }
 }
