//
//  EditCostViewModel.swift
//  hands
//
//  Created by 山浦功 on 2018/05/21.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import Foundation

class EditCostViewModel {
    
    private var cost: Cost

    init(eventId: String, complition: @escaping (Bool) -> Void) {
        self.cost = Cost(id: UUID().uuidString, created_at: NSDate(), event_id: eventId, cost: 0)
        CostUtil().getCostByEventId(eventId: eventId) { (cost) in
            if let cost = cost {
                self.cost = cost
                complition(true)
            } else {
                complition(false)
            }
        }
    }
    
    func getData(eventId: String, complition: @escaping (Bool) -> Void) {
        CostUtil().getCostByEventId(eventId: eventId) { (cost) in
            if let cost = cost {
                self.cost = cost
                complition(true)
            } else {
                complition(false)
            }
        }
    }
    
    func update(cost: Int, complition: @escaping (Bool) -> Void) {
        self.cost.cost = cost
        CostUtil().update(target: self.cost) { (result) in
            complition(result)
        }
    }
    
    func delete(complition: @escaping (Bool) -> Void) {
        CostUtil().destroy(target: cost) { (result) in
            complition(result)
        }
    }
    
    func getCost() -> Int {
        return cost.cost
    }
}
