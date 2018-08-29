//
//  RequestDetailsVC.swift
//  Requestor
//
//  Created by Prosha on 12/10/2015.
//  Copyright © 2015 Prosha Pshenichny Apps. All rights reserved.
//

import UIKit


/// This ViewController is responsible for the display of the selected response UITableViewCells from the View Controller two.

class RequestDetailsVC: UIViewController, UITextViewDelegate {
    
    
    @IBOutlet weak var textViewOutlet: UITextView!
    @IBOutlet weak var segmentControlOutlet: UISegmentedControl!
    let parseJson = ParseRequest.init(host_adress: "None")
    let dataModel = dataManager.dataModel
    
    // This function displays the content of a response baded on the segment selected.
    @IBAction func segmentControlAction(_ sender: AnyObject) {
        
        let dataModel = dataManager.dataModel
        
        let selectedSegment = self.segmentControlOutlet.selectedSegmentIndex
        
        switch selectedSegment {
            
            case 0:
                
                textViewOutlet.text = "Domain: " + self.parseJson.parseHTTPURL(String(describing: dataModel.responseObject[dataModel.selectedIndex].HTTPResponse))  + "\n" + "Status Code: " + String(dataModel.responseObject[dataModel.selectedIndex].HTTPResponse.statusCode) + "\n" + "Method: " + dataManager.dataModel.HTTPMethod  + "\n" + "Date: " + self.parseJson.parseHTTPResponseDate(String(describing: dataModel.responseObject[dataModel.selectedIndex].HTTPResponse))
            
            case 1:
                textViewOutlet.text = String(describing: dataManager.dataModel.responseObject[dataModel.selectedIndex].HTTPResponse)
            
            case 2:
                textViewOutlet.text = dataModel.responseObject[dataModel.selectedIndex].responseBody as String

            
        default:
            textViewOutlet.text = "None"
            
        }
        
    }
    
    //
    
    
    // View Did Load
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        textViewOutlet.text = "Domain: " + self.parseJson.parseHTTPURL(String(describing: dataModel.responseObject[dataModel.selectedIndex].HTTPResponse))  + "\n" + "Status Code: " + String(dataModel.responseObject[dataModel.selectedIndex].HTTPResponse.statusCode) + "\n" + "Method: " + dataManager.dataModel.HTTPMethod  + "\n" + "Date: " + self.parseJson.parseHTTPResponseDate(String(describing: dataModel.responseObject[dataModel.selectedIndex].HTTPResponse))

        
        textViewOutlet.delegate = self
        
    
    
    }

    // Did Receive Memory Warning
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }
    
    //
    
    
    //Keyboard control for UITextView editing.
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    //


}

//
