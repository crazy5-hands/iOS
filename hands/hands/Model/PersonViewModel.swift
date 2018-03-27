//
//  PersonViewModel.swift
//  hands
//
//  Created by 山浦功 on 2017/12/27.
//  Copyright © 2017年 KoYamaura. All rights reserved.
//

import Foundation
import RealmSwift
import UIKit


class Person: Object{
    dynamic var id = 0
    //    dynamic var accessToken = ""
    dynamic var lineUserId = 0
    dynamic var displayName = ""
    var group = List<Event>()
    dynamic var pictureURL = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}


final class PersonViewModel {
    var id = 0
    var lineUserId = 0
    var displayName = ""
    var group = [Event]()
    var pictureURL = ""
    
    static let dao = Model<Person>()
    
    init(_ object: Person){
        id = object.id
        lineUserId = object.lineUserId
        displayName = object.displayName
        for i in object.group {
            self.group.append(i)
        }
        pictureURL = object.pictureURL
    }
    
    static func load() -> [PersonViewModel] {
        let object = dao.findAll()
        return object.map{ PersonViewModel($0) }
    }
    
    func update() {
        let dao = type(of: self).dao
        guard let object = dao.findFirst(key: id as AnyObject) else {
            return
        }
        let new = Person()
        new.id = object.id
        new.lineUserId = object.lineUserId
        new.displayName = object.displayName
        for i in self.group {
            new.group.append(i)
        }
        new.pictureURL = object.pictureURL
        let _ = dao.update(d: new)
    }
    
//    func delete() {
//        let dao = type(of: self).dao
//        guard let object = dao.findFirst(key: id as AnyObject) else {
//            return
//        }
//        dao.delete(d: object)
//    }
    
//    static func create() -> PersonViewModel {
//        let object = Person()
//        object.id = dao.newId()!
//        dao.add(d: object)
//        return PersonViewModel(object)
//    }
}
