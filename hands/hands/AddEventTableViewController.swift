//
//  AddEventViewController.swift
//  hands
//
//  Created by 山浦功 on 2017/12/27.
//  Copyright © 2017年 KoYamaura. All rights reserved.
//

import UIKit

let pickerAnimationDuration = 0.40 // duration for the animation to slide the date picker into view
let datePickerTag           = 99   // view tag identifiying the date picker view
let titleKey = "title" // key for obtaining the data source item's title
let dateKey  = "date"  // key for obtaining the data source item's date value
// keep track of which rows have date cells
let dateStartRow = 1
let dateEndRow   = 2


let titleCellID = "titleCell"
let dateCellID   = "dateCell"   // the cells with the start or end date
let datePickerID = "datePicker" // the cell containing the date picker
let otherCell    = "otherCell"// the remaining cells at the end
let memoCellID = "memoCell"

class AddEventTableViewController: UITableViewController, TextTableViewCellDelegate{
    
    var dataArray = [[String: AnyObject]]()
    var start = NSDate()
    var end = NSDate()
    var titleText: String?
    
    // keep track which indexPath points to the cell with UIDatePicker
    var datePickerIndexPath: NSIndexPath?
    
    lazy var pickerCellRowHeight: CGFloat = {
        [unowned self] in
        
        // obtain the picker view cell's height, works because the cell was pre-defined in our storyboard
        let pickerViewCellToCheck = self.tableView.dequeueReusableCell(withIdentifier: datePickerID)
        
        return pickerViewCellToCheck!.frame.height
        }()
    
    @IBOutlet weak var titleTextField: UITextField!
    /// Primary view has been loaded for this view controller
    ///
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setup our data source
        let itemOne: [String: AnyObject] = [titleKey: "Tap a cell to change its date:" as AnyObject]
        let itemTwo: [String: AnyObject] = [titleKey: "開始時間" as AnyObject, dateKey: NSDate()]
        let itemThree: [String: AnyObject] = [titleKey: "終了時間" as AnyObject, dateKey: NSDate()]
        let itemFour: [String: AnyObject] = [titleKey: "メモ" as AnyObject]
        self.dataArray = [itemOne, itemTwo, itemThree]
        
        
        // if the local changes while in the background, we need to be notified so we can update the date
        // format in the table view cells
        //
        NotificationCenter.default.addObserver(self, selector: Selector(("localeChanged:")), name: NSLocale.currentLocaleDidChangeNotification, object: nil)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(AddEventTableViewController.update))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSLocale.currentLocaleDidChangeNotification, object: nil)
    }
    
    // MARK: - Locale
    /// Responds to region format or locale changes.
    ///
    func localeChanged(notif: NSNotification) {
        // the user changed the locale (region format) in Settings, so we are notified here to
        // update the date format in the table view cells
        //
        self.tableView.reloadData()
    }
    
    // MARK: - Utilities
    /// Determines if the given indexPath has a cell below it with a UIDatePicker.
    ///
    /// - parameters:
    ///   - indexPath: The indexPath to check if its cell has a UIDatePicker below it.
    ///
    func hasPickerForIndexPath(indexPath: NSIndexPath) -> Bool {
        var hasDatePicker = false
        
        var targetedRow = indexPath.row
        targetedRow += 1
        
        let checkDatePickerCell = self.tableView.cellForRow(at: IndexPath.init(row: targetedRow, section: 0))
        let checkDatePicker = checkDatePickerCell?.viewWithTag(datePickerTag)
        
        hasDatePicker = checkDatePicker != nil
        return hasDatePicker
    }
    
    /// Updates the UIDatePicker's value to match with the date of the cell above it.
    ///
    func updateDatePicker() {
        if (self.datePickerIndexPath != nil) {
            let associatedDatePickerCell = self.tableView.cellForRow(at: self.datePickerIndexPath! as IndexPath)
            let targetedDatePicker = associatedDatePickerCell?.viewWithTag(datePickerTag) as? UIDatePicker
            
            if (targetedDatePicker != nil) {
                // we found a UIDatePicker in this cell, so update it's date value
                //
                let itemData = self.dataArray[self.datePickerIndexPath!.row - 1]
                targetedDatePicker!.setDate((itemData[dateKey] as! NSDate) as Date, animated: false)
            }
        }
    }
    
    /// Determines if the UITableViewController has a UIDatePicker in any of its cells.
    ///
    func hasInlineDatePicker() -> Bool {
        return self.datePickerIndexPath != nil
    }
    
    /// Determines if the given indexPath points to a cell that contains the UIDatePicker.
    ///
    /// - parameters:
    ///   - indexPath: The indexPath to check if it represents a cell with the UIDatePicker.
    ///
    func indexPathHasPicker(indexPath: NSIndexPath) -> Bool {
        return self.hasInlineDatePicker() && self.datePickerIndexPath!.row == indexPath.row
    }
    
    /// Determines if the given indexPath points to a cell that contains the start/end dates.
    ///
    /// - parameters:
    ///   - indexPath: The indexPath to check if it represents start/end date cell.
    ///
    func indexPathHasDate(indexPath: NSIndexPath)-> Bool {
        var hasDate = false
        
        if ((indexPath.row == dateStartRow) ||
            (indexPath.row == dateEndRow || (self.hasInlineDatePicker() && (indexPath.row == dateEndRow + 1))))
        {
            hasDate = true
        }
        
        return hasDate
    }
    
    // MARK: - UITableViewDataSource
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.indexPathHasPicker(indexPath: indexPath as NSIndexPath) ? self.pickerCellRowHeight : self.tableView.rowHeight
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.hasInlineDatePicker()) {
            // we have a date picker, so allow for it in the number of rows in this section
            let numRows = self.dataArray.count
            return numRows + 1
        }
        
        return self.dataArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell?
        var cellID = titleCellID
        
        if (self.indexPathHasPicker(indexPath: indexPath as NSIndexPath)) {
            cellID = datePickerID
        } else if (self.indexPathHasDate(indexPath: indexPath as NSIndexPath)) {
            cellID = dateCellID
        }
        
        if cellID == titleCellID {
            let titleCell = tableView.dequeueReusableCell(withIdentifier: cellID) as! TextTableViewCell
            titleCell.delegate = self
            return titleCell
        }else {
            cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        }
//        if (indexPath.row == 0) {
//            // we decide here that first cell in the table is not selectable (it's just an indicator)
//            cell!.selectionStyle = UITableViewCellSelectionStyle.none;
//        }
        
        var modelRow = indexPath.row
        if (self.datePickerIndexPath != nil && self.datePickerIndexPath!.row <= indexPath.row) {
            modelRow -= 1
        }
        
        let itemData = self.dataArray[modelRow]
        
        if (cellID == dateCellID) {
            cell!.textLabel!.text = itemData[titleKey] as? String
            cell!.detailTextLabel!.text = DateUtils.stringFromDate(date: (itemData[dateKey] as! NSDate))
//                self.dateFormatter.string(from: (itemData[dateKey] as! NSDate) as Date)
        }
        return cell!
    }
    
    /// Adds or removes a UIDatePicker cell below the given indexPath.
    ///
    /// - parameters:
    ///   - indexPath: The indexPath to reveal the UIDatePicker.
    ///
    func toggleDatePickerForSelectedIndexPath(indexPath: NSIndexPath) {
        self.tableView.beginUpdates()
        
        let indexPaths = [IndexPath.init(row: indexPath.row + 1, section: 0)]
        
        if (self.hasPickerForIndexPath(indexPath: indexPath)) {
            self.tableView.deleteRows(at: indexPaths, with: UITableViewRowAnimation.fade)
        } else {
            self.tableView.insertRows(at: indexPaths, with: UITableViewRowAnimation.fade)
        }
        self.tableView.endUpdates()
    }
    
    /// Reveals the date picker inline for the given indexPath, called by "didSelectRowAtIndexPath".
    ///
    /// - parameters:
    ///   - indexPath: The indexPath to reveal the UIDatePicker.
    ///
    func displayInlineDatePickerForRowAtIndexPath(indexPath: NSIndexPath) {
        self.tableView.beginUpdates()
        
        var before = false
        if (self.hasInlineDatePicker()) {
            before = self.datePickerIndexPath!.row < indexPath.row
        }
        
        let sameCellClicked = self.datePickerIndexPath?.row == indexPath.row + 1
        
        if (self.hasInlineDatePicker()) {
            self.tableView.deleteRows(at: [IndexPath.init(row: (self.datePickerIndexPath?.row)!, section: 0)], with: .fade)
            self.datePickerIndexPath = nil
        }
        
        if (!sameCellClicked) {
            let rowToReveal = before ? indexPath.row - 1 : indexPath.row
            let indexPathToReveal = IndexPath.init(row: rowToReveal, section: 0)
            
            self.toggleDatePickerForSelectedIndexPath(indexPath: indexPathToReveal as NSIndexPath)
            self.datePickerIndexPath = IndexPath.init(row: indexPathToReveal.row + 1, section: 0) as NSIndexPath
        }
        
        self.tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        self.tableView.endUpdates()
        self.updateDatePicker()
    }
    
    // MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath as IndexPath)
        if (cell!.reuseIdentifier == dateCellID) {
            self.displayInlineDatePickerForRowAtIndexPath(indexPath: indexPath as NSIndexPath)
        } else {
            tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        }
    }
    
    // MARK: - Actions
    /// User chose to change the date by changing the values inside the UIDatePicker.
    ///
    /// - parameters:
    ///   - sender: The sender for this action: UIDatePicker.
    ///
    @IBAction func dateAction(sender: UIDatePicker) {
        if (self.datePickerIndexPath != nil) {
            let targetedCellIndexPath = IndexPath.init(row: (self.datePickerIndexPath?.row)! - 1, section: 0)
            let cell = self.tableView.cellForRow(at: targetedCellIndexPath)
            let targetedDatePicker = sender
            
            var itemData = self.dataArray[targetedCellIndexPath.row]
            itemData[dateKey] = targetedDatePicker.date as AnyObject
            cell!.detailTextLabel?.text = DateUtils.stringFromDate(date: targetedDatePicker.date as NSDate)
        }
    }
    
    func textData(_ text: String) {
        self.titleText = text
    }
}


extension AddEventTableViewController{
    
    func update(){
        if titleText == nil {
            showAlart()
        }else {
            let object = EventViewModel.create()
            object.title = self.titleText!
            var itemData = dataArray[1]
            object.start = itemData[dateKey] as! NSDate
            itemData = dataArray[2]
            object.end = itemData[dateKey] as! NSDate
            object.created = NSDate()
            object.update()
            print("データを登録")
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func showAlart(){
        let title = "入力エラー"
        let message = "イベント名が入力されていません。"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:{
            // ボタンが押された時の処理を書く（クロージャ実装）
            (action: UIAlertAction!) -> Void in
            print("OK")
        })
        alert.addAction(defaultAction)
        present(alert, animated: true, completion: nil)
    }
}
