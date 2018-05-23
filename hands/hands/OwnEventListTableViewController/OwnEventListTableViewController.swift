//
//  OwnEventListTableViewController.swift
//  hands
//
//  Created by 山浦功 on 2018/05/23.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import UIKit

class OwnEventListTableViewController: EventListTableViewController {
    
    var userId: String?
    
    override func loadData() {
        DispatchQueue.global(qos: .userInitiated).async {
            if let userId = self.userId {
                EventUtil().getOwnEvents(authorId: userId, complition: { (events) in
                    self.events = self.orderByCreatedAt(events: events)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
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
