//
//  ArchivedRequestVC.swift
//  Requestor
//
//  Created by Prosha on 20/10/2015.
//  Copyright © 2015 Prosha Pshenichny Apps. All rights reserved.
//

import UIKit


/// This ViewController is responsible for the view of the archived requests.

class ArchivedRequestVC: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var textViewOutlet: UITextView!
    @IBOutlet weak var segmentControlOutlet: UISegmentedControl!
    let parseJson = ParseRequest.init(host_adress: "none")
    var dataModel = dataManager.dataModel
    
    // This button displays the response info based upon the selected Segment, and parses the output accordingly.
    @IBAction func segmentControlAction(_ sender: AnyObject) {
        
        
        
        
        let selectedSegment = self.segmentControlOutlet.selectedSegmentIndex
        
        switch selectedSegment {
            
            
        case 0:
            
          textViewOutlet.text = "Domain: " + self.parseJson.parseHTTPURL(String(describing: dataManager.dataModel.responseArchive[self.dataModel.selectedIndex].HTTPResponse))  + "\n" + "Status Code: " +  String(dataManager.dataModel.responseArchive[self.dataModel.selectedIndex].HTTPResponse.statusCode) + "\n" + "Method: " + dataManager.dataModel.responseArchive[self.dataModel.selectedIndex].HTTPMethod  + "\n" + "Date: " + self.parseJson.parseHTTPResponseDate(String(describing: dataManager.dataModel.responseArchive[self.dataModel.selectedIndex].HTTPResponse))
            
        case 1:
            
            textViewOutlet.text = String(describing: dataManager.dataModel.responseArchive[dataModel.selectedIndex].HTTPResponse)
            
        case 2:
            
            textViewOutlet.text = String(describing: dataManager.dataModel.responseArchive[dataModel.selectedIndex].responseBody)
            
        default:
            
            textViewOutlet.text = dataModel.responseArchive[dataModel.selectedIndex].responseBody as String
            
        }
        
        
    }
    //
    
    // View Did Load
    override func viewDidLoad() {
        
        textViewOutlet.delegate = self
          textViewOutlet.text = "Domain: " + self.parseJson.parseHTTPURL(String(describing: dataManager.dataModel.responseArchive[self.dataModel.selectedIndex].HTTPResponse))  + "\n" + "Status Code: " + String(dataManager.dataModel.responseArchive[self.dataModel.selectedIndex].HTTPResponse.statusCode) + "\n" + "Method: " + dataManager.dataModel.responseArchive[self.dataModel.selectedIndex].HTTPMethod  + "\n" + "Date: " + self.parseJson.parseHTTPResponseDate(String(describing: dataManager.dataModel.responseArchive[self.dataModel.selectedIndex].HTTPResponse))
        super.viewDidLoad()

    }
    //
    
    // Did Receive Memory Warning.
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }
    //
    
    
    //Keyboard Control.
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
