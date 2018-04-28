//
//  EventTableViewCell.swift
//  hands
//
//  Created by 山浦功 on 2018/04/28.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import UIKit
import Firebase

class EventTableViewCell: UITableViewCell {

//    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var createAtLabel: UILabel!
    var eventKey: String?
    var eventRef: DatabaseReference!
    
    func updateCell(eventKey: String, title: String, body: String, createAt: String) {
        self.eventKey = eventKey
        self.titleLabel.text = title
        self.bodyLabel.text = body
        self.createAtLabel.text = createAt
    }
    
    @IBAction func submitJoin(_ sender: Any) {
        if let eventKey = self.eventKey {
            eventRef = Database.database().reference().child("events").child(eventKey)
            
        }
    }
    
    private func increaseJoin(forRef ref: DatabaseReference) {
        ref.runTransactionBlock({ (currentData) -> TransactionResult in
            if var event = currentData.value as? [String: AnyObject], let uid = Auth.auth().currentUser?.uid {
                var joiner: Dictionary<String, Bool>
                joiner = event["joiner"] as? [String: Bool] ?? [:]
                var joinerCount = event["joinerCount"] as? Int ?? 0
                if let _ = joiner[uid] {
                    joinerCount -= 1
                    joiner.removeValue(forKey: uid)
                } else {
                    joinerCount += 1
                    joiner[uid] = true
                }
                
                event["joinerCount"] = joinerCount as AnyObject?
                event["joiner"] = joiner as AnyObject?
                
                currentData.value = event
                return  TransactionResult.success(withValue: currentData)
            }
            return TransactionResult.success(withValue: currentData)
        }) { (error, bool, snapshot) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}
