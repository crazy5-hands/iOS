//
//  StoryboardLoadble.swift
//  hands
//
//  Created by 山浦功 on 2018/08/30.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import UIKit

/// ストーリーボード上のUIViewControllerインスタンス作成のプロトコル
protocol StoryboardLoadable: class {
    static var storyboardName: String { get }
    static var storyboardID: String? { get }
    
    static func fromStoryboard(withStoryboardID storyboardID: String?) -> Self
    static func fromStoryboard() -> Self
}

extension StoryboardLoadable where Self: UIViewController {
    
    static var storyboardName: String {
        return "Main"
    }
    
    static var storyboardID: String? {
        return "\(self)"
    }
    
    static func fromStoryboard(withStoryboardID storyboardID: String?) -> Self{
        let sb = UIStoryboard(name: self.storyboardName, bundle: nil)
        if let storyboardID = storyboardID {
            return sb.instantiateViewController(withIdentifier: storyboardID) as! Self
        } else {
            return sb.instantiateInitialViewController() as! Self
        }
    }
    
    static func fromStoryboard() -> Self {
        return self.fromStoryboard(withStoryboardID: storyboardID)
    }
}
