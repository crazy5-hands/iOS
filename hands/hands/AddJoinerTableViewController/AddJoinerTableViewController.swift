//
//  AddJoinerTableViewController.swift
//  hands
//
//  Created by 山浦功 on 2018/06/25.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import UIKit
import Firebase

class AddJoinerTableViewController: UsersTableViewController {

    var eventId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
         self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
         self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
            tableView.insertRows(at: [indexPath], with: .right)
        }    
    }

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
    
    func addJoiner() {
        guard let indexPaths = self.tableView.indexPathsForSelectedRows else { return }
        let group = DispatchGroup()
        var fail = false
        
        for indexPath in indexPaths {
            let user = self.users[indexPath.row]
            let db = Firestore.firestore()
            guard let eventId = self.eventId else { return }
            let newJoin = Join(id: UUID().uuidString, event_id: eventId, user_id: user.id, created_at: NSDate())
            
            group.enter()
            db.collection("joins").document(newJoin.id).setData(newJoin.dictionary) { (error) in
                if error != nil {
                    fail = true
                }
                group.leave()
            }
        }
        // finish 
        group.notify(queue: .main) {
            if fail == true {
                self.showAlert("追加に失敗しました。")
            } else {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
}
