//
//  AllEventTableViewController.swift
//  hands
//
//  Created by 山浦功 on 2018/05/22.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import Foundation
import UIKit

class AllEventTableViewController: EventListTableViewController {
    
    override func loadData() {
        DispatchQueue.global(qos: .userInitiated).async {
            EventUtil().getEventsAll(complition: { (events) in
                let newEvents = events
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                    self.events = newEvents
                    self.loadData()
                })
            })
        }
    }
}
