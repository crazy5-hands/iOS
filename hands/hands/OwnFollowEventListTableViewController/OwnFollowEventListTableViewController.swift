//
//  OwnFollowTableViewController.swift
//  hands
//
//  Created by 山浦功 on 2018/05/23.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import UIKit

class OwnFollowEventListTableViewController: EventListTableViewController {
    
    var userId: String?
    
    override func loadData() {
        self.startLoading()
        DispatchQueue.global(qos: .userInitiated).async {
            if let uid = self.userId {
                let group = DispatchGroup()
                group.enter()
                EventUtil().getOwnEvents(authorId: uid, complition: { (events) in
                    self.events += events
                    group.leave()
                })
                group.enter()
                FollowUtil().getFollows(user_id: uid, complition: { (follows) in
                    let semaphore = DispatchSemaphore(value: 0)
                    for follow in follows {
                        EventUtil().getOwnEvents(authorId: follow.follow_id, complition: { (events) in
                            self.events += events
                            semaphore.signal()
                        })
                        semaphore.wait(timeout: DispatchTime(uptimeNanoseconds: 1))
                    }
                    group.leave()
                })
                group.notify(queue: .main, execute: {
                    self.reloadData()
                })
            }
        }
    }
}
