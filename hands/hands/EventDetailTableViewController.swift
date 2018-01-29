//
//  EventDetailTableViewController.swift
//  hands
//
//  Created by 山浦功 on 2018/01/26.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import UIKit

class EventDetailTableViewController: UITableViewController {

    var eventViewModel: EventViewModel?
    var cellIdentifier = ["EventDetailHeaderViewCell", "memberTableViewCell", "memoTableViewCell"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("event detail table view cotroller")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cellIdentifier.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier[indexPath.row]) as? EventDetailHeaderTableViewCell {
                cell.update(eventViewModel!)
                return cell
            }
        case 1:
            if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier[indexPath.row]) as? MemberTableViewCell {
                cell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.row)
                return cell
            }
        case 2:
            if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier[indexPath.row]) as? MemoTableViewCell {
                return cell
            }
        default: return UITableViewCell()
        }
        return UITableViewCell()
    }
    


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
}


extension EventDetailTableViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (eventViewModel?.member.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "memberCollectionViewCell", for: indexPath)
        return cell
    }
}
