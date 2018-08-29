//
//  RequestsNumberVC.swift
//  
//
//  Created by Prosha on 29/10/2015.
//
//

import UIKit

/// This view controller is responsible for the UIPickerView that generates the number of requests to be made.

class RequestsNumberVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var pickerViewOutlet: UIPickerView!
  
    var pickerData = [String]()
    var selectedAmount = Int()
    
    
   
    // ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Appends the number of avilable requests to be stored in the UIPikcerViewl.
        for item in 1...10000 {
            pickerData.append(String(item))
        }
        //
        
        
        // UI settings and configuration for the appearance of the UIPikceerView (pickerViewOutlet).
        pickerViewOutlet.layer.cornerRadius = 80
        pickerViewOutlet.layer.masksToBounds = true
        pickerViewOutlet.layer.borderWidth = 1
        pickerViewOutlet.layer.borderColor = UIColor.white.cgColor
        //
        
        // Set the delegate of the UIPickerView.
        pickerViewOutlet.dataSource = self
        pickerViewOutlet.delegate = self
        //
    //
        
    }
    
    
  
    // Did recieve memory warninig.
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    // Set the number of components to be displayed in the UIPickerView.
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    //
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    
    // Creates the title to be used for each row of the UIPickerView.
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        
        return pickerData[row]
    }
    //
    
    // Creates an action upon selection of one of the rows in the UIPickerView.
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        
        // Sets the numberOfRequests var to store the selected value from the UIPickerView.
        dataManager.dataModel.numberOfRequests = Int(pickerData[row])!
        //print(pickerData[row])
    }
    //
    
    // Sets additional attributes for each row of the UIPickerView.
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
        let titleData = pickerData[row]
        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 15.0)!,NSForegroundColorAttributeName:UIColor.black])
        
        
        return myTitle
    }


}
