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
                var newEvents: [Event] = []
                let group = DispatchGroup()
                group.enter()
                EventUtil().getOwnEvents(authorId: uid, complition: { (events) in
                    newEvents += events
                    group.leave()
                })
                group.enter()
                FollowUtil().getFollows(user_id: uid, complition: { (follows) in
                    let group2 = DispatchGroup()
                    for follow in follows {
                        group2.enter()
                        EventUtil().getOwnEvents(authorId: follow.follow_id, complition: { (events) in
                            newEvents += events
                            group2.leave()
                        })
                        
                    }
                    group2.notify(queue: .main, execute: {
                        group.leave()
                    })
                })
                group.notify(queue: .main, execute: {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                        self.events = newEvents
                        self.reloadData()
                    })
                })
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                    self.navigationItem.prompt = "表示するデータがありません。"
                })
            }
        }
    }
}
