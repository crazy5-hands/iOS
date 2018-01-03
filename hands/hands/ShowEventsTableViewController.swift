//
//  ShowEventsViewController.swift
//  hands
//
//  Created by 山浦功 on 2017/12/27.
//  Copyright © 2017年 KoYamaura. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


class ShowEventsTableViewController: UITableViewController {
    
    let disposeBag = DisposeBag()
    var objects = [EventViewModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(ShowEventsTableViewController.segueAdd))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail" {
            let target = segue.destination as! DetailEventViewController
            target.object = sender as? EventViewModel
        }
    }
    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! EventTableViewCell
//        cell.update(objects[indexPath.row])
//        return cell
//    }
}

extension ShowEventsTableViewController{
    
    func segueAdd(){
        print("追加画面に遷移")
        self.performSegue(withIdentifier: "add", sender: nil)
    }
    
    func segueDetail(){
        print("詳細画面")
        self.performSegue(withIdentifier: "", sender: nil)
    }
}
