//
//  TableViewController.swift
//  Requestor
//
//  Created by Prosha on 03/10/2015.
//  Copyright © 2015 Prosha Pshenichny Apps. All rights reserved.
//

import UIKit
import Alamofire


/// This ViewController controls/gathers all of the settings/info to make requests (Settings View Controller).

class SettingsVC: UITableViewController, UITextFieldDelegate {
   
    
    
    @IBOutlet weak var numberOfParametersTextFieldOutlet: UILabel!
    @IBOutlet weak var requestBarButtonItemOutlet: UIBarButtonItem!
    @IBOutlet weak var naviGationItemOutlet: UINavigationItem!
    @IBOutlet weak var numberOfHeadersTextFieldOutlet: UILabel!
    @IBOutlet weak var requestTypeTextField: UILabel!
    @IBOutlet var urlTableViewCell: UITableViewCell!
    @IBOutlet var requestTypeCell: UITableViewCell!
    @IBOutlet weak var numberOfRequestsCell: UITableViewCell!
    @IBOutlet weak var requestIntervalsCell: UITableViewCell!
    @IBOutlet weak var multipleRequestsCellOutlet: UITableViewCell!
    @IBOutlet var multiRequestSwitchOutlet: UISwitch!
    @IBOutlet weak var urlSettingsLabelOutlet: UILabel!
    @IBOutlet weak var numberOfRequestsTextFieldOutlet: UILabel!
    @IBOutlet weak var requestIntervalTextFieldOutlet: UILabel!
    @IBOutlet weak var switchOutlet: UISwitch!
    
    
    
    var selectedRequest = String()
    var testJson = [HTTPURLResponse]()
    let settingsTitles = ["URL settings", "HEADERS AND PARAMETERS", "Requests"]
    let numberOfRowsInSection = [2, 2, 3]
    let parseJson = ParseRequest(host_adress: "URL")

 

  
    /// Keyboard control.
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
    }
    
    
    
    /// Keyboard control.
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        return true
    }
    
    
    
    /// View Did Load.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //Custmoize UItableViewCells behavior upon load.
        
        multipleRequestsCellOutlet.selectionStyle = UITableViewCellSelectionStyle.none
        
        
        //Set the state of the switch upon load
        
        switchOutlet.setOn(false, animated: false)
        
        
        //Hide elements upon load
        
        requestIntervalsCell.isHidden = true
        numberOfRequestsCell.isHidden = true
        
        
        //Customizes the navigation title image
        let image = UIImage.init(named: "WhiteSettings66px@3x.png")
        let imageView = UIImageView.init(image: image)
        
        //let imageView = UIImageView.init(image: UIImage(imageLiteral: "WhiteSettings66px@3x.png"))
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        self.navigationItem.titleView = imageView
        
        
        // Set the number of the requests and intervals for the session.
        
        requestTypeTextField.text = dataManager.dataModel.HTTPMethod
        numberOfRequestsTextFieldOutlet.text = String(dataManager.dataModel.numberOfRequests)
        requestIntervalTextFieldOutlet.text = String(dataManager.dataModel.requestInterval)
        urlSettingsLabelOutlet.text = dataManager.dataModel.selectedURLType
    
    
     
        ObjectManager.archiveDataManager()
        
        tableView.backgroundView?.backgroundColor = UIColor.orange
        tableView.reloadData()
        
    }
    
    
    
    
    /// View Did Appear.
    
    override func viewDidAppear(_ animated: Bool) {
        
        tableView.reloadData()
       
        
    }
    
    
    
    
    /// View Will Appear.
    
    override func viewWillAppear(_ animated: Bool) {
        
        requestTypeTextField.text = dataManager.dataModel.HTTPMethod
        urlSettingsLabelOutlet.text = dataManager.dataModel.selectedURLType
        
        
        
        
        // Checks to see if there are stored params/headers and display them if needed.
        
        numberOfRequestsTextFieldOutlet.text = String(dataManager.dataModel.numberOfRequests)
        requestIntervalTextFieldOutlet.text = String(dataManager.dataModel.requestInterval) + "s"
        
        if dataManager.dataModel.parameterDict.count == 0 {
            
            numberOfParametersTextFieldOutlet.text = "None"
            
        } else {
            
             numberOfParametersTextFieldOutlet.text = String(dataManager.dataModel.parameterDict.count)
        }

        if dataManager.dataModel.headersDict.count == 0 {
            
            numberOfHeadersTextFieldOutlet.text = "None"
            
        } else {
            numberOfHeadersTextFieldOutlet.text = String(dataManager.dataModel.headersDict.count)
        }
        
      
        
    }
  
    
    
    /// View Did Disappear
    override func viewDidDisappear(_ animated: Bool) {
    
        dataManager.dataModel.HTTPMethod = requestTypeTextField.text!
        tableView.reloadData()
    }
    
    
    /// Did Recieve Memory Warning.
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    
    /// Sets the sections of the TableView.
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return settingsTitles.count
    }
    
    
    // Sets the number of UITableViewCells rows in the UITableView.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let numberOfRows = numberOfRowsInSection[section]
        
        return numberOfRows
    }
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let title = settingsTitles[section]
        
        return title
    }
    
    
    /// Hides or shows the multiple requests options UITableViewCells.
    
    @IBAction func enabledMultipleRequestsSwitch(_ sender: AnyObject) {
        if switchOutlet.isOn != true {
        
        let hideCellAnimated = CATransition()
        hideCellAnimated.type = kCATransitionFade
        hideCellAnimated.duration = 0.4
        numberOfRequestsCell.layer.add(hideCellAnimated, forKey: nil)
        requestIntervalsCell.layer.add(hideCellAnimated, forKey: nil)
        requestIntervalsCell.isHidden = true
        numberOfRequestsCell.isHidden = true
        
        } else {
            
            let hideCellAnimated = CATransition()
            hideCellAnimated.type = kCATransitionFade
            hideCellAnimated.duration = 0.2
            numberOfRequestsCell.layer.add(hideCellAnimated, forKey: nil)
            
            requestIntervalsCell.layer.add(hideCellAnimated, forKey: nil)
            requestIntervalsCell.isHidden = false
            numberOfRequestsCell.isHidden = false
            
            
            
        }
    }
    
    
}



