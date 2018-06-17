//
//  TableViewController.swift
//  hands
//
//  Created by 山浦功 on 2018/06/17.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    private let kSectionSum: Int = 0
    private let kSectionPay: Int = 1
    private let kSectionPayButton: Int = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(50)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected")
    }
}
