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
    dynamic var memo = ""
    dynamic var created = NSDate()
}


final class EventViewModel {
    var id = 0
    var title = ""
    var start = NSDate()
    var owner = Person()
    var member = [Person]()
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
    
    static let dao = Model<Event>()
    
    init(_ object: Event){
        id = object.id
        title = object.title
        start = object.start
        owner = object.owner
        for i in object.member{
            member.append(i)
        }
        memo = object.memo
        created = object.created
    }
    
    static func load() -> [EventViewModel]{
        let object = dao.findAll()
        return object.map{ EventViewModel($0) }
    }
    
    static func create() -> EventViewModel {
        let object = Event()
        object.id = dao.newId()!
        dao.add(d: object)
        return EventViewModel(object)
    }
    
    func update() {
        let dao = type(of: self).dao
        guard let object = dao.findFirst(key: id as AnyObject) else {
            return
        }
        let new = Event()
        new.id = object.id
        new.title = title
        new.start = start
        new.owner = owner
        for i in member {
            new.member.append(i)
        }
        new.memo = memo
        new.created = created
        let _ = dao.update(d: new)
    }
    
    func delete() {
        let dao = type(of: self).dao
        guard let object = dao.findFirst(key: id as AnyObject) else {
            return
        }
        dao.delete(d: object)
    }
}
