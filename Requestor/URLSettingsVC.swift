//
//  URLSettingsVC.swift
//  
//
//  Created by Prosha on 07/10/2015.
//
//

import UIKit


/// This ViewController is responsible for the management and input of URLs.

class URLSettingsVC: UIViewController, UITableViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var SettingsVCOutlet: UITableView!
    @IBOutlet weak var urlInputTextField: UITextField!
    
    
    
    
    
    
    
    // This is the URL add button which appends http/https based upon users input of the url.
    @IBAction func addURLButton(_ sender: AnyObject) {
       
        if urlInputTextField.text!.contains("http://") || urlInputTextField.text!.contains("https://") {
            
            
            
            SettingsVCOutlet.beginUpdates()
            //url_rows.append(urlInputTextField.text!)
            dataManager.dataModel.url_rows.insert(urlInputTextField.text!, at: 0)
            let indexPath = IndexPath(row: 0, section: 0)
            
            self.SettingsVCOutlet.insertRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
            
           
            SettingsVCOutlet.endUpdates()
            
            
        }
            
        else {
            
            SettingsVCOutlet.beginUpdates()
            //url_rows.append(urlInputTextField.text!)
            dataManager.dataModel.url_rows.insert("http://" + urlInputTextField.text!, at: 0)
            let indexPath = IndexPath(row: 0, section: 0)
            
            self.SettingsVCOutlet.insertRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
            
            
            SettingsVCOutlet.endUpdates()
        }
    }
    
    
    
    //Hide the keyboard upon action.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
    }
    
    //
    
    // Hides the keyboard upon return press.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        urlInputTextField.delegate = self
        urlInputTextField.resignFirstResponder()
        
        return true
    }
    //

    
    /// View Did Load.
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // AutoSize the urlInputTextField.
        urlInputTextField.autoresizingMask = UIViewAutoresizing.flexibleWidth
        urlInputTextField.delegate = self
       
    }
    //
    
    
    ///View Did Disappear.
    
    override func viewDidDisappear(_ animated: Bool) {
        
        ObjectManager.archiveDataManager()
        
    }
    
    
    //Did Receive Memory Warning.
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /// Table view cells count setting.
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataManager.dataModel.url_rows.count
    }
    
    
    /// Set tableview sells.
    
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "URLCELL")
        
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        cell.textLabel?.text = dataManager.dataModel.url_rows[(indexPath as NSIndexPath).row] as String
        cell.textLabel?.textColor = UIColor.black
        
        return cell
    
    }
    
    //
    
    //Create custom actions upon swipe in the tableView.
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
            let delete = UITableViewRowAction(style: .normal, title: "Delete") { action, index in
            
                self.SettingsVCOutlet.beginUpdates()
                
                dataManager.dataModel.url_rows.remove(at: (indexPath as NSIndexPath).row)
                self.SettingsVCOutlet.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
                
                ObjectManager.archiveDataManager()
                
                
                self.SettingsVCOutlet.endUpdates()
        }
        
        delete.backgroundColor = UIColor.red
        
        return [delete]
    }
    
    //
    
    
    //Perform action upon selected tableViewCell in a tableView.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
   
        let lastSelectedIndexPath = tableView.indexPathForSelectedRow
        let cell = tableView.cellForRow(at: lastSelectedIndexPath!)

        dataManager.dataModel.selectedURL = ((lastSelectedIndexPath as NSIndexPath?)?.row)!
        dataManager.dataModel.selectedURLType = (cell?.textLabel?.text)!
        
        ObjectManager.archiveDataManager()
        
        self.navigationController?.popToRootViewController(animated: true)
        
        //performSegueWithIdentifier("urlWasSelected", sender: indexPath.row) // performs a segue.
    }
    
    
}

