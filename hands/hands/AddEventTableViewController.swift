//
//  AddEventViewController.swift
//  hands
//
//  Created by 山浦功 on 2017/12/27.
//  Copyright © 2017年 KoYamaura. All rights reserved.
//

import UIKit

class AddEventTableViewController: UITableViewController {
    
    let datePickerTag = 99
    let dateStartRow = 1
    let dateEndRow   = 2
    
    var dateFormatter: DateFormatter = {
        var dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = .short // show short-style date format
        dateFormatter.timeStyle = .none
        
        return dateFormatter
    }()
    
    lazy var pickerCellRowHeight: CGFloat = {
        [unowned self] in
        
        // obtain the picker view cell's height, works because the cell was pre-defined in our storyboard
        let pickerViewCellToCheck = self.tableView.dequeueReusableCell(withIdentifier: "datePicker")
        
        return pickerViewCellToCheck!.frame.height
        }()
    
    var datePickerIndexPath: IndexPath?
    var dataArray = [[String: AnyObject]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let itemOne: [String: AnyObject] = ["title": "Tap a cell to change its date:" as AnyObject]
        let itemTwo: [String: AnyObject] = ["title": "Start Date" as AnyObject, "date": NSDate()]
        let itemThree: [String: AnyObject] = ["title": "End Date" as AnyObject, "date": NSDate()]
        let itemFour: [String: AnyObject] = ["title": "(other item1)" as AnyObject]
        let itemFive: [String: AnyObject] = ["title": "(other item2)" as AnyObject]
        self.dataArray = [itemOne, itemTwo, itemThree, itemFour, itemFive]


        NotificationCenter.default.addObserver(self, selector: Selector(("localeChanged:")), name: NSLocale.currentLocaleDidChangeNotification, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func localeChanged(notif: NSNotification) {
        self.tableView.reloadData()
    }
    
    
    //set up tableView
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return self.indexPathHasPicker(indexPath: indexPath) ? self.pickerCellRowHeight : self.tableView.rowHeight
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.hasInlineDatePicker()) {
            // we have a date picker, so allow for it in the number of rows in this section
            let numRows = self.dataArray.count
            return numRows + 1
        }
        
        return self.dataArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell?
        var cellID = "otherCell"
        
        if (self.indexPathHasPicker(indexPath: indexPath)) {
            // the indexPath is the one containing the inline date picker
            cellID = "datePicker"     // the current/opened date picker cell
        } else if (self.indexPathHasDate(indexPath: indexPath)) {
            // the indexPath is one that contains the date information
            cellID = "dateCell"     // the start/end date cells
        }
        
        cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        
        if (indexPath.row == 0) {
            // we decide here that first cell in the table is not selectable (it's just an indicator)
            cell!.selectionStyle = .none;
        }
        
        // if we have a date picker open whose cell is above the cell we want to update,
        // then we have one more cell than the model allows
        //
        var modelRow = indexPath.row
        if (self.datePickerIndexPath != nil && self.datePickerIndexPath!.row <= indexPath.row) {
            modelRow -= 1
        }
        
        let itemData = self.dataArray[modelRow]
        
        // proceed to configure our cell
        if (cellID == "dateCell") {
            // we have either start or end date cells, populate their date field
            //
            cell!.textLabel!.text = itemData["title"] as? String
            cell!.detailTextLabel!.text = self.dateFormatter.string(from: (itemData["date"] as! NSDate) as Date)
        } else if (cellID == "otherCell") {
            // this cell is a non-date cell, just assign it's text label
            //
            cell!.textLabel!.text = itemData["title"] as? String
        }
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRow(at: indexPath as IndexPath)
        if (cell!.reuseIdentifier == "dateCell") {
            self.displayInlineDatePickerForRowAtIndexPath(indexPath: indexPath as IndexPath)
        } else {
            tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        }
    }
}




extension AddEventTableViewController{
    
    //選択されたセルの次のセルにUIDatePickerがあるかどうか確認する
    func hasPickerForIndexPath(_ indexPath: IndexPath) -> Bool {
        var hasDatePicker = false
        
        var targetedRow = indexPath.row
        targetedRow += 1
        
        let checkDatePickerCell = self.tableView.cellForRow(at: IndexPath(row: targetedRow, section: 0))
        let checkDatePicker = checkDatePickerCell?.viewWithTag(datePickerTag)
        
        hasDatePicker = checkDatePicker != nil
        return hasDatePicker
    }
    
    //UIDatePickerで選んだ日付と時間を一つ上のcellのラベルに代入する
    func updateDatePicker() {
        if (self.datePickerIndexPath != nil) {
            let associatedDatePickerCell = self.tableView.cellForRow(at: self.datePickerIndexPath!)
            let targetedDatePicker = associatedDatePickerCell?.viewWithTag(datePickerTag) as? UIDatePicker
            
            if (targetedDatePicker != nil) {
                let itemData = self.dataArray[self.datePickerIndexPath!.row - 1]
                targetedDatePicker!.setDate((itemData["date"] as! NSDate) as Date, animated: false)
            }
        }
    }
    
    //選択されたセルがUIDatePickerを含むセルかどうかを判定
    func indexPathHasPicker(indexPath: NSIndexPath) -> Bool {
        return self.hasInlineDatePicker() && self.datePickerIndexPath!.row == indexPath.row
    }
    
    func hasInlineDatePicker() -> Bool {
        return self.datePickerIndexPath != nil
    }
    
    //選択されたセルが日付を含むのかを判定
    func indexPathHasDate(indexPath: NSIndexPath)-> Bool {
        var hasDate = false
        
        if ((indexPath.row == dateStartRow) ||
            (indexPath.row == dateEndRow || (self.hasInlineDatePicker() && (indexPath.row == dateEndRow + 1))))
        {
            hasDate = true
        }
        return hasDate
    }
    
    //UIDatePickerを表示する
    func displayInlineDatePickerForRowAtIndexPath(indexPath: IndexPath) {
        self.tableView.beginUpdates()
        
        var before = false   // indicates if the date picker is below "indexPath", help us determine which row to reveal
        if (self.hasInlineDatePicker()) {
            before = self.datePickerIndexPath!.row < indexPath.row
        }
        
        let sameCellClicked = self.datePickerIndexPath?.row == indexPath.row + 1
        
        // remove any date picker cell if it exists
        if (self.hasInlineDatePicker()) {
            self.tableView.deleteRows(at: [IndexPath.init(row: (self.datePickerIndexPath?.row)!, section: 0)], with: .fade)
            self.datePickerIndexPath = nil
        }
        
        if (!sameCellClicked) {
            // hide the old date picker and display the new one
            let rowToReveal = before ? indexPath.row - 1 : indexPath.row
            let indexPathToReveal = IndexPath.init(row: rowToReveal, section: 0)
            
            self.toggleDatePickerForSelectedIndexPath(indexPath: indexPathToReveal)
            self.datePickerIndexPath = IndexPath.init(row: indexPathToReveal.row + 1, section: 0)
        }
        
        self.tableView.deselectRow(at: indexPath, animated: true)
        self.tableView.endUpdates()
        
        // inform our date picker of the current date to match the current cell
        self.updateDatePicker()
    }
    
    //選択されたセルの下のUIDatePickerを表示・消す
    func toggleDatePickerForSelectedIndexPath(indexPath: IndexPath) {
        self.tableView.beginUpdates()
        
        let indexPaths = [IndexPath.init(row: indexPath.row + 1, section: 0)]
        
        // check if 'indexPath' has an attached date picker below it
        if (self.hasPickerForIndexPath(indexPath)) {
            // found a picker below it, so remove it
            self.tableView.deleteRows(at: indexPaths, with: .fade)
        } else {
            // didn't find a picker below it, so we should insert it
            self.tableView.insertRows(at: indexPaths, with: .fade)
        }
        
        self.tableView.endUpdates()
    }
}
