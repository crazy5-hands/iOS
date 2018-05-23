//
//  JoinEventListTableViewController.swift
//  hands
//
//  Created by 山浦功 on 2018/05/23.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import UIKit

class JoinEventListTableViewController: EventListTableViewController {
    
    var userId: String?
    
    override func loadData() {
        DispatchQueue.global(qos: .userInitiated).async {
            if let userId = self.userId {
                let group = DispatchGroup()
                JoinUtil().getJoinsByUserId(userId: userId, complition: { (joins) in
                    group.enter()
                    for join in joins {
                        EventUtil().getEventById(id: join.event_id, complition: { (event) in
                            if let event = event {
                                self.events.append(event)
                            }
                            group.leave()
                        })
                    }
                    group.notify(queue: .main, execute: {
                        self.reloadData()
                    })
                })
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                    self.navigationItem.prompt = "データがありません。"
                })
            }
        }
    }
}
