//
//  EventViewModel.swift
//  hands
//
//  Created by 山浦功 on 2017/12/27.
//  Copyright © 2017年 KoYamaura. All rights reserved.
//

import Foundation
import RealmSwift
import UIKit


class Event: Object{
    dynamic var id = 0
    dynamic var title = ""
    dynamic var start = NSDate()
    dynamic var owner = Person()
    var member = List<Person>()
    dynamic var budget = 0
    dynamic var memo = ""
    dynamic var created = NSDate()
}


final class EventViewModel {
    var id = 0
    var title = ""
    var start = NSDate()
    var owner = Person()
    var member = [Person]()
    var budget = 0
    var memo = ""
    var created = NSDate()
    
    var ownerName: String {
        return self.owner.displayName
    }
    
    var memberName: [String]{
        var names = [String]()
        for i in self.member {
            names.append(i.displayName)
        }
        return names
    }
    
    
}
