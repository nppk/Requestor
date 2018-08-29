//
//  ParamsVC.swift
//  Requestor
//
//  Created by Prosha on 25/10/2015.
//  Copyright © 2015 Prosha Pshenichny Apps. All rights reserved.
//

import UIKit

var parameterDict = [String: String]() // This dict stores the amount of parameters added.




/// This class is responsible for settings/input of parameters for a request.

class ParamsVC: UIViewController, UITableViewDelegate, UITextFieldDelegate {

    // Outlet properties.
    
    @IBOutlet weak var keyTextFieldOutlet: UITextField!
    @IBOutlet weak var valueTextFieldOutlet: UITextField!
    @IBOutlet weak var tableViewOutlet: UITableView!
   

    
    
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
          
            dataManager.dataModel.parameterDict.removeAll()
            self.tableViewOutlet.layer.add(animatedClear, forKey: nil)
            self.tableViewOutlet.reloadData()
        
            
        })
        
        
        
        
        
        // Add alert action to aleret
        
        editAlert.addAction(aleretActionCancel)
        editAlert.addAction(alertActionDelete)
        
        
        self.present(editAlert, animated: true, completion: nil)
        
        
        
    }

    
    override func viewWillDisappear(_ animated: Bool) {
        
        

      
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        ObjectManager.archiveDataManager()
    
    }
    
    
    @IBAction func addKeyValueButton(_ sender: UIBarButtonItem) {
        
        let key = keyTextFieldOutlet.text!
        let value = valueTextFieldOutlet.text!
        
        
        dataManager.dataModel.parameterDict[key] = value
        
        ObjectManager.archiveDataManager()
        tableViewOutlet.reloadData()

    }
    
    
    
    
    /// View DId end Editing
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        

    }
    
    
    /// View Did Load
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        
        self.keyTextFieldOutlet.delegate = self
        self.valueTextFieldOutlet.delegate = self
        valueTextFieldOutlet.autoresizingMask = UIViewAutoresizing.flexibleWidth
        
    }
    
    
    ///Did Receive Memory Warning.
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    /// Sets the number of UITableViewCells.
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataManager.dataModel.parameterDict.count
    }
    
    
    
    
    /// Sets custome actinos for the UITableView upon swipe to left, creates the delete button.
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .normal, title: "Delete") { action, index in
            
            
            self.tableViewOutlet.beginUpdates()
            
            dataManager.dataModel.parameterDict.removeValue(forKey: Array(dataManager.dataModel.parameterDict.keys)[(indexPath as NSIndexPath).row])
            self.tableViewOutlet.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
    
            
            ObjectManager.archiveDataManager()
            
            self.tableViewOutlet.endUpdates()
        
        }
        
        delete.backgroundColor = UIColor.red
        return [delete]
    }
    
    
    
    
    /// UITableViewCell settings.
    
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "paramCell")
    
      

        let key = Array(dataManager.dataModel.parameterDict.keys)[(indexPath as NSIndexPath).row]
        let value = Array(dataManager.dataModel.parameterDict.keys)[(indexPath as NSIndexPath).row]
        
        
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        cell.textLabel?.text = key + " : " + value
        
        return cell
    
    }
    

    
    override func resignFirstResponder() -> Bool {
        
        self.valueTextFieldOutlet.resignFirstResponder()
        self.keyTextFieldOutlet.resignFirstResponder()
        

        return true
    }
    
    
    
    /// Keyboard control.
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.valueTextFieldOutlet.resignFirstResponder()
        self.keyTextFieldOutlet.resignFirstResponder()
        

        return true
    }
    
    
    /// Keyboard control.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
