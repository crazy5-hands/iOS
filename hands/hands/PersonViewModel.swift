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
}


final class PersonViewModel {
    var id = 0
    var lineUserId = 0
    var displayName = ""
    var group = [Event]()
    var pictureURL = ""
    
    init(_ object: Person){
        id = object.id
        lineUserId = object.lineUserId
        
        pictureURL = object.pictureURL
    }
}
