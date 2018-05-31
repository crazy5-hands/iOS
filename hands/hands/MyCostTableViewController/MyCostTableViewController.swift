//
//  MyCostTableViewController.swift
//  hands
//
//  Created by 山浦功 on 2018/05/31.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import UIKit
import Firebase

class MyCostTableViewController: CostTableViewController {
    
    override func loadData() {
        self.startLoading()
        DispatchQueue.global(qos: .userInitiated).async {
            if let uid = Auth.auth().currentUser?.uid {
                EventUtil().getOwnEvents(authorId: uid, complition: { (events) in
                    var newCosts: [Cost] = []
                    for event in events {
                        CostUtil().getCostByEventId(eventId: event.id, complition: { (cost) in
                            if let cost = cost {
                                newCosts.append(cost)
                            }
                        })
                    }
                    self.events = self.sortEventsByDate(events: events)
                    self.costs = self.sortCostsByDate(costs: newCosts)
                })
            }
            DispatchQueue.main.async {
                self.endLoading()
                self.tableView.reloadData()
            }
        }
    }
}
