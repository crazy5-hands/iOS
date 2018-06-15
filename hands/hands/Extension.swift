//
//  Extension.swift
//  hands
//
//  Created by 山浦功 on 2018/04/12.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    //alert 
    func showAlert(_ message: String) {
        let alert = UIAlertController(title: "エラー", message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(defaultAction)
        present(alert, animated: true, completion: nil)
    }
    
    func showDialog(_ title: String, _ message: String, complition: (() -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "はい", style: .default) { (alert) in
            complition!()
        }
        let cancelAction = UIAlertAction(title: "キャンセル", style: .default, handler: nil)
        alert.addAction(cancelAction)
        alert.addAction(defaultAction)
        present(alert, animated: true, completion: nil)
    }
    
    func showOKAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(defaultAction)
        present(alert, animated: true, completion: nil)
    }
}

