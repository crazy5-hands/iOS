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
    let items = Observable<[EventViewModel]>.just(EventViewModel.load())

    override func viewDidLoad() {
        super.viewDidLoad()
        items.bind(to: self.tableView.rx.items(cellIdentifier: "cell", cellType: EventTableViewCell.self)){ (row, element, cell) in
            cell.update(element)
            
            }.disposed(by: disposeBag)
        
        tableView.rx
            .itemAccessoryButtonTapped
            .subscribe { (indexPath) in
                print("\(String(describing: indexPath.element?.row))")
            }.disposed(by: disposeBag)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
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
