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
                        let event = EventUtil().getEventById(id: join.event_id)
                        if let event = event {
                            self.events.append(event)
                        }
                        group.leave()
                    }
                    group.notify(queue: .main, execute: {
                        self.reloadData()
                    })
                })
            }
        }
    }
}
