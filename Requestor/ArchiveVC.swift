//
//  ArchiveViewController.swift
//  Requestor
//
//  Created by Prosha on 20/10/2015.
//  Copyright © 2015 Prosha Pshenichny Apps. All rights reserved.
//

import UIKit


/// This ViewController is responsible for the view/editing of the archived requests.

class ArchiveVC: UIViewController, UITableViewDelegate {
    
    
    
    @IBOutlet weak var tableViewOutlet: UITableView!
    @IBOutlet weak var archivedRequestsLabelOutlet: UILabel!
    @IBOutlet weak var archiveIsEmptyImageViewOutlet: UIImageView!
    @IBOutlet weak var makeRequestButtonOutlet: UIButton!
    @IBAction func segueToRequestas(_ sender: AnyObject) {
        
        self.tabBarController?.selectedIndex = 1
        
        
        
    }
    

    
    // View Did Load.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //Customizes the navigationBar title image and navigationBar Items
        let image = UIImage.init(named: "WhiteArchive66px@3x.png")
        let imageView = UIImageView.init(image: image)
        
        self.navigationItem.titleView = imageView
        
  
        // Check to see if there are stored respones in archive, if so enable UI elements.
        
        if !dataManager.dataModel.responseArchive.isEmpty {
            
            tableViewOutlet.reloadData()
            
            tableViewOutlet.isHidden = false
            archiveIsEmptyImageViewOutlet.isHidden = true
           
            
        } else {
            
            
            tableViewOutlet.isHidden = true
            archiveIsEmptyImageViewOutlet.isHidden = false
            
           
        }
        

        

    }
    

    override func viewWillAppear(_ animated: Bool) {
        
        
        
    }
    
    
    
    
    /// View Did Disappear.
    
    override func viewDidDisappear(_ animated: Bool) {
        

    }
    
    
    
    /// View Did Appear.
    
    override func viewDidAppear(_ animated: Bool) {
        
        
        // Set no archive items if there are no items in tableView
        
        tableViewOutlet.reloadData()
        
        if dataManager.dataModel.responseArchive.isEmpty {
            
            tableViewOutlet.isHidden = true
            archiveIsEmptyImageViewOutlet.isHidden = false
            //archivedRequestsLabelOutlet.hidden = false
            
        } else {
            
            tableViewOutlet.isHidden = false
            archiveIsEmptyImageViewOutlet.isHidden = true
         
        }
        
        
        tableViewOutlet.reloadData()
    }
    
    
    

    /// Did Receive Memory Warning.
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    
    
    /// Sets the number of UITableViewCells in a section.
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataManager.dataModel.responseArchive.count
    }
    
    
    /// tableView cells settings.
    
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        
        let parseJson = ParseRequest.init(host_adress: "none")
        
        let customCell: RequestTVCell = self.tableViewOutlet.dequeueReusableCell(withIdentifier: "archiveCell") as! RequestTVCell
        
        
        
        customCell.titleLabelOutlet.textColor = UIColor.white
        customCell.additionalInfoLabelOutlet.textColor = UIColor.white
        customCell.dateLabelOutlet.textColor = UIColor.white
        
   
    
        
        if dataManager.dataModel.responseArchive[(indexPath as NSIndexPath).row].HTTPMethod == "GET" {
            
            customCell.methodImageView.image = UIImage(named: "GET.png")
            
        }
        
        if  dataManager.dataModel.responseArchive[(indexPath as NSIndexPath).row].HTTPMethod == "POST" {
            
    
            customCell.methodImageView.image = UIImage(named: "POST.png")
            
        }
        
        if  dataManager.dataModel.responseArchive[(indexPath as NSIndexPath).row].HTTPMethod == "PATCH" {
            
            customCell.methodImageView.image = UIImage(named: "PATCH.png")
            
        }
        
        if  dataManager.dataModel.responseArchive[(indexPath as NSIndexPath).row].HTTPMethod == "PUT" {
            
            
            customCell.methodImageView.image = UIImage(named: "PUT.png")
            
        }
        
        if  dataManager.dataModel.responseArchive[(indexPath as NSIndexPath).row].HTTPMethod == "DELETE" {
            
            
            customCell.methodImageView.image = UIImage(named: "DELETE.png")
            
        }
        
        if  dataManager.dataModel.responseArchive[(indexPath as NSIndexPath).row].HTTPMethod == "OPTIONS" {
            
        
            customCell.methodImageView.image = UIImage(named: "OPTIONS.png")
            
        }
        
        if  dataManager.dataModel.responseArchive[(indexPath as NSIndexPath).row].HTTPMethod == "HEAD" {
            
            
            customCell.methodImageView.image = UIImage(named: "HEAD.png")
            
        }
        
        
        
        customCell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        
        customCell.titleLabelOutlet!.text = dataManager.dataModel.responseArchive[(indexPath as NSIndexPath).row].HTTPMethod + " " +
            String(dataManager.dataModel.responseArchive[(indexPath as NSIndexPath).row].HTTPResponse.statusCode)
        
        customCell.dateLabelOutlet!.text = parseJson.parseHTTPResponseDate(String(describing: dataManager.dataModel.responseArchive[(indexPath as NSIndexPath).row].HTTPResponse))
        
        customCell.additionalInfoLabelOutlet!.text = parseJson.parseHTTPURL(String(describing: dataManager.dataModel.responseArchive[(indexPath as NSIndexPath).row].HTTPResponse))
        
        
        return customCell
        
    }
    
    
    /// Sets a delete action upon left swipe on a UITableViewCell.
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .normal, title: "Delete") { action, index in
            
            
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
            
            dataManager.dataModel.responseArchive.remove(at: (indexPath as NSIndexPath).row)
            ObjectManager.archiveDataManager()
            
    
            tableView.endUpdates()
            
        }
       
        delete.backgroundColor = UIColor.red
        
        return [delete]
    }
    
    

    
    /// Performs an action upon UITableViewCell selection based on it's index.
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        dataManager.dataModel.selectedIndex = (indexPath as NSIndexPath).row
        tableViewOutlet.deselectRow(at: indexPath, animated: true)
        ObjectManager.archiveDataManager()
        
        
        
    }
    
    
    /// This is an action sheet for deleting archived requests.

    @IBAction func actionSheet(_ sender: AnyObject) {
        
        let alertControl = UIAlertController(title: "DELETE ALL ARCHIVED REQUESTS", message: "Are you sure?", preferredStyle: UIAlertControllerStyle.actionSheet)
        
        let alertCancel = UIAlertAction.init(title: "CANCEL", style: UIAlertActionStyle.default, handler: nil)
        
        
    
        let alertDelete = UIAlertAction.init(title: "DELETE ALL", style: UIAlertActionStyle.destructive, handler: {(alert :UIAlertAction!) in
            
        
            
            let animatedClear = CATransition()
            animatedClear.type = kCATransitionPush
            animatedClear.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            animatedClear.fillMode = kCAFillModeForwards
            animatedClear.duration = 0.5
            animatedClear.subtype = kCATransitionFromBottom
            dataManager.dataModel.responseArchive.removeAll()
            ObjectManager.archiveDataManager()
            
            
            
            self.tableViewOutlet.layer.add(animatedClear, forKey: nil)
            self.tableViewOutlet.reloadData()
            
            
            
        })
        
        
        alertControl.addAction(alertDelete)
        alertControl.addAction(alertCancel)
        self.present(alertControl, animated: true, completion: nil)
        
        
        
        
    }


    
}


