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
        self.tableView.register(nib, forCellReuseIdentifier: "event")
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

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
