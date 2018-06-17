//
//  TableViewController.swift
//  hands
//
//  Created by 山浦功 on 2018/06/17.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import UIKit
import Firebase

class TableViewController: UITableViewController {

    private let kSectionSum: Int = 0
    private let kSectionPay: Int = 1
    private let kSectionPayButton: Int = 2
    private var pays: [Pay] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let payButtonNib = UINib(nibName: "PayButtonTableViewCell", bundle: nil)
        self.tableView.register(payButtonNib, forCellReuseIdentifier: "payButton")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case kSectionPay:
            return self.pays.count
        default:
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case kSectionPayButton:
            let cell = tableView.dequeueReusableCell(withIdentifier: "payButton") as! PayButtonTableViewCell
            cell.selectionStyle = .none
            return cell
        default:
            let cell = UITableViewCell()
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case kSectionPayButton:
            return CGFloat(60)
        default:
            return CGFloat(50)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case kSectionPayButton:
            //show alert
            print("ehhehe")
        default:
            break
        }
        print("selected")
    }
    
    private func laodData() {
        let firestore = Firestore.firestore()
        let payRef = firestore.collection("pays")
        let costRef = firestore.collection("costs")
        let joinRef = firestore.collection("joins")
        var costs: [Cost] = []
        var joins: [Join] = []
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        // get pay
        let queue = DispatchQueue(label: "pay")
        queue.sync {
            let group = DispatchGroup()
            payRef.whereField("user_id", isEqualTo: uid).whereField("paid", isLessThan: false).getDocuments(completion: { (snapshot, error) in
                if let snapshot = snapshot {
                    group.enter()
                    for document in snapshot.documents {
                        let pay = Pay(dictionary: document.data())!
                        self.pays.append(pay)
                        group.leave()
                    }
                }
            })
            group.notify(queue: .global(), execute: {
                let costGroup = DispatchGroup()
                for pay in self.pays {
                    costRef.whereField("event_id", isLessThan: pay.event_id).getDocuments(completion: { (snapshot, error) in
                        if let snapshot = snapshot {
                            costGroup.enter()
                            for document in snapshot.documents {
                                let cost = Cost(dictionary: document.data())!
                                costs.append(cost)
                                costGroup.leave()
                            }
                        }
                    })
                    joinRef.whereField("event_id", isLessThan: pay.event_id).getDocuments(completion: { (snapshot, error) in
                        if let snapshot = snapshot {
                            costGroup.enter()
                            for document in snapshot.documents {
                                let join = Join(dictionary: document.data())!
                                joins.append(join)
                                costGroup.leave()
                            }
                        }
                    })
                }
                costGroup.notify(queue: .main, execute: {
                    // 金額の計算
                    self.tableView.reloadData()
                })
            })
        }
    }
}

enum APIPayError: Error {
    case network
    case pay
    case cost
    case unknown(message: String)
}
