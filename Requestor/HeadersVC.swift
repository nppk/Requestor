//
//  HeadersVC.swift
//  Requestor
//
//  Created by Prosha on 25/10/2015.
//  Copyright © 2015 Prosha Pshenichny Apps. All rights reserved.
//

import UIKit



var dataManager = DataManager.sharedInstance // Singletone global var for easy global access.

/// This class is responsible for the settings and the input of custome request headers.

class HeadersVC: UIViewController, UITableViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var tableViewOutlet: UITableView!
    @IBOutlet weak var headerKeyTextFieldOutlet: UITextField!
    @IBOutlet weak var headerValueTextFieldOutlet: UITextField!
    



    /// This button clears all of the headers in the tableView.
    
    @IBAction func editBarButton(_ sender: AnyObject) {
        
        let editAlert = UIAlertController.init(title: "Edit", message: "Clear all headers?", preferredStyle: UIAlertControllerStyle.alert)
        let aleretActionCancel = UIAlertAction.init(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
        let alertActionDelete = UIAlertAction.init(title: "CLEAR", style: UIAlertActionStyle.destructive, handler: {(alert :UIAlertAction!) in
            
  
            
                        // Animation for Clearing the tableView
                        let animatedClear = CATransition()
                        animatedClear.type = kCATransitionPush
                        animatedClear.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
                        animatedClear.fillMode = kCAFillModeForwards
                        animatedClear.duration = 0.5
                        
                        dataManager.dataModel.headersDictTableViewDisplay.removeAll()
                        dataManager.dataModel.headersDict.removeAll()
            
                        ObjectManager.archiveDataManager()
            
                        self.tableViewOutlet.layer.add(animatedClear, forKey: nil)
                        self.tableViewOutlet.reloadData()
            
        })
        
        
        
        // Add alert action to aleret
        
        editAlert.addAction(alertActionDelete)
        editAlert.addAction(aleretActionCancel)
        
        self.present(editAlert, animated: true, completion: nil)
        
    
    }
 
    
    
    /// This button adds the key:value pairs to the UITableView.
    
    @IBAction func addKeyValueButton(_ sender: AnyObject) {
        
        let key = headerKeyTextFieldOutlet.text
        let value = headerValueTextFieldOutlet.text
        
       
        dataManager.dataModel.headersDict[key!] = value
        
        ObjectManager.archiveDataManager()
        
        tableViewOutlet.reloadData()

  
    }

    
    
    /// Keyboard Control.
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    
    override func viewDidDisappear(_ animated: Bool) {
    
        
        ObjectManager.archiveDataManager()
        
        
        
    }
    
    /// View Did Load
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        self.headerKeyTextFieldOutlet.delegate = self
        self.headerValueTextFieldOutlet.delegate = self
        headerValueTextFieldOutlet.autoresizingMask = UIViewAutoresizing.flexibleWidth
        
    }
    
    
    /// Keyboard control.
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    
        headerKeyTextFieldOutlet.resignFirstResponder()
        
        headerValueTextFieldOutlet.resignFirstResponder()
        
    return true
        
    }
    

    /// Did Recieve Memory Warning.
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }
    
    
    /// Sets the UITableViewCells rows based upon the dict count.
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataManager.dataModel.headersDict.count
        
        
    }
    
    
    /// Creates actions upon swipe to left of a UItableViewCell in the UITableView, adds the Delete button.
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .normal, title: "Delete") { action, index in
            
            self.tableViewOutlet.beginUpdates()
            
            
            dataManager.dataModel.headersDict.removeValue(forKey: Array(dataManager.dataModel.headersDict.keys)[(indexPath as NSIndexPath).row])
            

            ObjectManager.archiveDataManager()
            
            
            self.tableViewOutlet.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
            
            self.tableViewOutlet.endUpdates()
        }
    
        delete.backgroundColor = UIColor.red
        
        return [delete]
    }
    
    
    /// TableView cells presentation .
    
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "headerCell")
        
        
        let key =  Array(dataManager.dataModel.headersDict.keys)[(indexPath as NSIndexPath).row]
        let value = Array(dataManager.dataModel.headersDict.values)[(indexPath as NSIndexPath).row]
        
       
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        cell.textLabel?.text = key + " : " + value

        
        return cell
        
    }
    
    /// Actions upon selection of a UITableViewCell at it's index.
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableViewOutlet.deselectRow(at: indexPath, animated: true)
        
    }
    
    
}


