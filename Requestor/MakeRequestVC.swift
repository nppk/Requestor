
//
//  MakeRequestVC.swift
//  Requestor
//
//  Created by Prosha on 10/1/15.
//  Copyright © 2015 Prosha Pshenichny Apps. All rights reserved.
//

import UIKit
import Alamofire


/// This ViewController is responsible for all of the control/ storage of the requests made.

class MakeRequestVC: UIViewController, UITableViewDelegate, UINavigationBarDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var startButtonOutlet: UIBarButtonItem!
    @IBOutlet weak var customDateLabel: UILabel!
    @IBOutlet weak var activityIndicatorOutlet: UIActivityIndicatorView!
    @IBOutlet weak var navigationItemOutlet: UINavigationItem!
    @IBOutlet weak var tableViewControl: UITableView!
    @IBOutlet weak var clearRequestsBarButtonOutlet: UIBarButtonItem!
    
    
    
    let request:RequestModel = RequestModel()
    var reloadTimer = Timer() // The timer object init.
    var timer = dataManager.dataModel.numberOfRequests// Timer count (number of requests to be made).
    var requestInterval: Double = 0.1
    var barButtonActive = true
    
    let parseJson = ParseRequest.init(host_adress: "None")
    
    
    
    
    // Set the alerts and alert messages
    
    let alertClearTable = UIAlertController.init(title: "Clear Requests", message: "Clear all requests? ", preferredStyle: UIAlertControllerStyle.actionSheet)
    let alertNoConnection = UIAlertController.init(title: "Something went wrong!", message: "Invalid URL or no connection", preferredStyle: UIAlertControllerStyle.alert)
    let alertSelectURL = UIAlertController.init(title: "Seomthing went wrong!", message: "URL was not selected", preferredStyle: UIAlertControllerStyle.alert)
    let alertInvalidURL = UIAlertController.init(title: "Something went wrong!", message: "Invalid URL selected", preferredStyle: UIAlertControllerStyle.alert)
    let alertFinished = UIAlertController.init(title: "Finished!", message: "Requestor has finished working", preferredStyle: UIAlertControllerStyle.alert)
    let alertStopped = UIAlertController.init(title: "Requestor was stopped!", message: "Stopped by the user", preferredStyle: UIAlertControllerStyle.alert)
    let alertActionOK = UIAlertAction.init(title: "OK", style: UIAlertActionStyle.default, handler: nil)
    
    
    
    
    
    /// The super long and unpretty function which sets http method and to handle the requests based on the vars set in the settings view controller, and executes the case(works with NSTimer.scheduledTimerWithTimeInterval function).
    
    func makeRequest() {
    
        if timer > 0 {
            
            self.timer -= 1
            request.makeRequest(self, tbvc: self.tableViewControl, dataManager: dataManager, activityIndicatorView: self.activityIndicatorOutlet)
        
        }
        
        else {

            if dataManager.dataModel.responseObject.count == dataManager.dataModel.numberOfRequests {
                
             
               self.reloadTimer.invalidate()
               barButtonActive = true
                self.present(alertFinished, animated: true, completion: nil)
               
                activityIndicatorOutlet.stopAnimating()
               
               self.tableViewControl.reloadData()
            
            }
            
        }
        
        
    }
    
    
    
    /// View Did Disappear.
    
    override func viewDidDisappear(_ animated: Bool) {
        
        reloadTimer.invalidate()
        activityIndicatorOutlet.stopAnimating()
        barButtonActive = true
        
        
        
        ObjectManager.archiveDataManager()
        
    
        
    }
    
    
    /// View Did Load.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        alertStopped.addAction(alertActionOK)
        alertFinished.addAction(alertActionOK)
        
        alertSelectURL.addAction(alertActionOK)
        alertInvalidURL.addAction(alertActionOK)
        
        

        //Customizes the alert with messages/actions
        
        //Customize the navigation title
        let image = UIImage.init(named: "WhiteSettings66px@3x.png")
        let imageView = UIImageView.init(image: image)
        self.navigationItem.titleView = imageView
        
        // Paramters for the logs appearance.
        
        tableViewControl.layer.cornerRadius = 30
        tableViewControl.layer.masksToBounds = true
        tableViewControl.layer.borderColor = UIColor.orange.cgColor
        
    }
    
    
    /// Did Receive Memory Warning.
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
    }
    
    /// View Did Appear.
    
    override func viewDidAppear(_ animated: Bool) {
        
        
        
        dataManager.dataModel.barButtonActive = barButtonActive
        timer = dataManager.dataModel.numberOfRequests
        requestInterval = dataManager.dataModel.requestInterval
        tableViewControl.reloadData()
        
    }
    
    
    /// Returns the number of cells in a tableView section, uses the public cell_count var (create dynamicly).
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return dataManager.dataModel.responseObject.count
    }
    

    /// Set the dynamic cells behavior/ appearance.
    
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        
        
        // Create the custom cell.
        
        
        let customCell: RequestTVCell = self.tableViewControl.dequeueReusableCell(withIdentifier: "firstCell") as! RequestTVCell
        
        
        // Customize cell appearance.
        
        customCell.backgroundColor = UIColor.orange
        customCell.titleLabelOutlet.textColor = UIColor.white
        customCell.additionalInfoLabelOutlet.textColor = UIColor.black
        customCell.dateLabelOutlet.textColor = UIColor.black
        customCell.numberOfRequestsLabelOutlet.textColor = UIColor.black
        print(dataManager.dataModel.responseObject[(indexPath as NSIndexPath).row].HTTPResponse)
        //
        customCell.additionalInfoLabelOutlet.text =  String(describing: dataManager.dataModel.responseObject[(indexPath as NSIndexPath).row].HTTPResponse.value(forKey: "URL")!).components(separatedBy: "/")[2]
        
        customCell.titleLabelOutlet!.text = dataManager.dataModel.responseObject[(indexPath as NSIndexPath).row].HTTPMethod + " " + String(dataManager.dataModel.responseObject[(indexPath as NSIndexPath).row].HTTPResponse.statusCode)
        
        
        customCell.dateLabelOutlet.text = parseJson.parseHTTPResponseDate(String(describing: dataManager.dataModel.responseObject[(indexPath as NSIndexPath).row].HTTPResponse))
        customCell.numberOfRequestsLabelOutlet.text = String(dataManager.dataModel.cellCounter[(indexPath as NSIndexPath).row]) + " of " + String(dataManager.dataModel.cellCounter.count)
        
   
        
        //cell.textLabel!.font = UIFont.systemFontOfSize()
        customCell.layer.cornerRadius =  10
        customCell.layer.masksToBounds = true
        customCell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        
        return customCell
    }
    
    
    /// Selected request from tableView.
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        dataManager.dataModel.responseObject[(indexPath as NSIndexPath).row].selectedIndex = (indexPath as NSIndexPath).row
        tableViewControl.deselectRow(at: indexPath, animated: true)
    
    }
    
    
    /// Creates Delete/Archive buttons upon left swipe of a tableViewCell.
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .normal, title: "Delete") { action, index in
            
            
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
            
            dataManager.dataModel.responseObject.remove(at: (indexPath as NSIndexPath).row)
            ObjectManager.archiveDataManager()
            tableView.endUpdates()
            
        }
        
        let save = UITableViewRowAction(style: .normal, title: "Archive") { action, index in
            
            dataManager.dataModel.responseArchive.insert(dataManager.dataModel.responseObject[(indexPath as NSIndexPath).row], at: 0)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
            
            dataManager.dataModel.responseObject.remove(at: (indexPath as NSIndexPath).row)
            ObjectManager.archiveDataManager()
            
            tableView.endUpdates()
            
        
            
        }
        
        save.backgroundColor = UIColor.gray
        delete.backgroundColor = UIColor.red
        
        return [delete, save]
    }
    
    

    /// The button starts the operation of requestor.

    @IBAction func refreshTableView(_ sender: AnyObject) {
        
        
        if barButtonActive {
            
        activityIndicatorOutlet.startAnimating()
      
        // Checks for validity of the URL.
        barButtonActive = false
        if let _ = URL(string: dataManager.dataModel.selectedURLType) {
        
        dataManager.dataModel.responseObject.removeAll()
        dataManager.dataModel.cellCounter.removeAll()
        
        ObjectManager.archiveDataManager()
            
        self.tableViewControl.reloadData()
        
        
        timer = dataManager.dataModel.numberOfRequests
        
        if dataManager.dataModel.selectedURLType.characters.count != 0 {
            
            reloadTimer = Timer.scheduledTimer(timeInterval: TimeInterval(dataManager.dataModel.requestInterval), target: self, selector: #selector(MakeRequestVC.makeRequest), userInfo: nil, repeats: true)
           
            }
            
            
        else {
            
            self.present(alertSelectURL, animated: true, completion: nil)
            activityIndicatorOutlet.stopAnimating()
            barButtonActive = true
        
        }
        
        } else {

            self.present(alertSelectURL, animated: true, completion: nil)
            barButtonActive = true
            activityIndicatorOutlet.stopAnimating()
            
        }
            
        
        } else {
            
            reloadTimer.invalidate()
            barButtonActive = true
        
            activityIndicatorOutlet.stopAnimating()
            self.present(alertStopped, animated: true, completion: nil)
            
        }
        
    }
    
    @IBAction func stopRefresh(_ sender: AnyObject) {
       

        reloadTimer.invalidate()
        timer = dataManager.dataModel.numberOfRequests
        
        
    }
    
    /// Clears all of the UITableView.

    @IBAction func clearTableView(_ sender: AnyObject) {
        
        
        let alertControl = UIAlertController(title: "DELETE ALL REQUESTS", message: "Are you sure?", preferredStyle: UIAlertControllerStyle.alert)
        let alertCancel = UIAlertAction.init(title: "CANCEL", style: UIAlertActionStyle.default, handler: nil)
        let alertDelete = UIAlertAction.init(title: "DELETE", style: UIAlertActionStyle.destructive, handler: {(alert :UIAlertAction!) in
                        self.activityIndicatorOutlet.stopAnimating()
                        self.barButtonActive = true
            
            
                        let animatedClear = CATransition()
                        animatedClear.type = kCATransitionPush
                        animatedClear.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
                        animatedClear.fillMode = kCAFillModeForwards
                        animatedClear.duration = 0.5
                        animatedClear.subtype = kCATransitionFromBottom
                        self.tableViewControl.layer.add(animatedClear, forKey: nil)
                        self.reloadTimer.invalidate()
                        dataManager.dataModel.responseObject.removeAll()
                        
                        dataManager.dataModel.cellCounter.removeAll()
                        self.timer = dataManager.dataModel.numberOfRequests
                        self.tableViewControl.reloadData()
            
            
         })
        
            
        alertControl.addAction(alertDelete)
        alertControl.addAction(alertCancel)
        self.present(alertControl, animated: true, completion: nil)
        
        
    }
        
}
