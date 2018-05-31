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
                let group = DispatchGroup()
                var newEvents: [Event] = []
                var newCosts: [Cost] = []
                group.enter()
                EventUtil().getOwnEvents(authorId: uid, complition: { (events) in
                    newEvents = events
                    for event in events {
                        group.enter()
                        CostUtil().getCostByEventId(eventId: event.id, complition: { (cost) in
                            if let cost = cost {
                                newCosts.append(cost)
                                group.leave()
                            }
                        })
                    }
                    
                    group.leave()
                })
                group.notify(queue: .main, execute: {
                    self.events = self.sortEventsByDate(events:newEvents)
                    self.costs = self.sortCostsByDate(costs: newCosts)
                    self.endLoading()
                    self.tableView.reloadData()
                })
            } else {
                DispatchQueue.main.async {
                    self.endLoading()
                    self.navigationItem.prompt = "データの取得に失敗しました。"
                }
            }
        }
    }
}
