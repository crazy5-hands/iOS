//
//  EditCostViewModel.swift
//  hands
//
//  Created by 山浦功 on 2018/05/21.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import Foundation

class EditCostViewModel {
    
    private var cost: Cost? = nil
    
    init(event_id: String) {
        self.cost = Cost()
        self.cost?.event_id = event_id
    }
    
    func create(cost: Int, complition: @escaping (Bool) -> Void) {
        if self.cost != nil {
            self.cost!.id = UUID().uuidString
            self.cost!.created_at = NSDate()
            self.cost!.cost = cost
            CostUtil().create(newCost: self.cost!) { (result) in
                complition(result)
            }
        } else {
            complition(false)
        }
    }
    
    func update(cost: Int, complition: @escaping (Bool) -> Void) {
        if self.cost != nil {
            self.cost!.cost = cost
            CostUtil().update(target: self.cost!) { (result) in
                complition(result)
            }
        } else {
            complition(false)
        }
    }
    
    func delete(complition: @escaping (Bool) -> Void) {
        if let cost = self.cost {
            CostUtil().destroy(target: cost) { (result) in
                complition(result)
            }
        } else {
            complition(false)
        }
    }
}
