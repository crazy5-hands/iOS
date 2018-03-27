//
//  ProfileTableViewController.swift
//  hands
//
//  Created by 山浦功 on 2018/01/30.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import UIKit
import LineSDK

class ProfileTableViewController: UITableViewController {

    var apiClient: LineSDKAPI?
    var userName: String?
    var statusMessage: String?
    var pictureURLString: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        apiClient?.getProfile(queue: .main, completion: { (profile, error) in
            if error == nil{
                print("this is profile vc")
                print(profile?.displayName)
                print(profile?.statusMessage)
                self.userName = profile?.displayName
                self.statusMessage = profile?.statusMessage
                if profile?.pictureURL != nil {
                    self.pictureURLString = profile?.pictureURL?.absoluteString
                }
                self.tableView.reloadData()
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "profile") as! ProfileTableViewCell
            cell.updateCell(pictureURLString: pictureURLString, userName: self.userName, statusMessage: self.statusMessage, sumOfWillJoin: 3, sumOfJoined: 5)
            return cell

        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "switch") as! SwitchTableViewCell
            cell.update(title: "通知の許可", status: true)
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "switch") as! SwitchTableViewCell
            cell.update(title: "カレンダーへのアクセス", status: false)
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "switch") as! SwitchTableViewCell
            cell.update(title: "ユーザーIDで探す", status: false)
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
            return cell
        default:
            return UITableViewCell()
        }
    }



    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height: CGFloat!

        switch indexPath.row {
        case 0:
            height = 250

        default:
            height = 60
        }
        return height
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 1:
            print("その他の設定")
        default:
            print("default was called")
        }
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
