//
//  ShowEventsViewController.swift
//  hands
//
//  Created by 山浦功 on 2017/12/27.
//  Copyright © 2017年 KoYamaura. All rights reserved.
//

import UIKit

class ShowEventsTableViewController: UITableViewController {
    
    var objects = [EventViewModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.objects = EventViewModel.load()
        let newObjects = self.objects.sorted(by: { $1.created.timeIntervalSince1970 < $0.created.timeIntervalSince1970 } )
        self.objects = newObjects
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! EventTableViewCell
        cell.update(objects[indexPath.row])
        return cell
    }
}
