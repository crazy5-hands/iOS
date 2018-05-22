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
    override func getEventIDs() -> [String] {
        var eventIDs: [String] = []
        EventUtil().getEventsAll { (events) in
            for event in events {
                eventIDs.append(event.id)
            }
        }
        return eventIDs
    }
}
