//
//  IntervalsVC.swift
//  Requestor
//
//  Created by Prosha on 30/10/2015.
//  Copyright © 2015 Prosha Pshenichny Apps. All rights reserved.
//

import UIKit

/// The class is responsible for the UIPickerView which sets the request intervals.

class IntervalsVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    
    @IBOutlet weak var pickerViewOutlet: UIPickerView!
    var pickerData = ["0.1", "0.5"] // Initial values for the UIPickerView.
    var selectedAmount = Int()
    
    
    // Did Recieve Memory Warning.
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    //
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        ObjectManager.archiveDataManager()
    }
    
    // View Did Load.
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        // Appends the maximum amount of possible requests to the pickerData var.
        for item in 1...9999 {
            
            pickerData.append(String(item))
        }
        
        
        
        
    
        //
        
        
        // UI settings and configuration for the appearance of the UIPikceerView (pickerViewOutlet).
        pickerViewOutlet.layer.cornerRadius = 80
        pickerViewOutlet.layer.masksToBounds = true
        pickerViewOutlet.layer.borderWidth = 1
        pickerViewOutlet.layer.borderColor = UIColor.white.cgColor
        
        //
        
        // UIPickerView appearance settings
        
        
        
        
        //
        
        // Delegate settings for the UIPickerView.
        pickerViewOutlet.dataSource = self
        pickerViewOutlet.delegate = self
        //
        
    }
    

    
    // Set the number of components in the UIPickerView.
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    //
    
    
    // Set the number of rows in each component of the UIPickerView.
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    
        return pickerData.count
    }
    //
    
    
    // Set the title for each row in the UIPickerView.
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        
        return pickerData[row]
        
    }
    //
    
    // Creates an action upon selection of a row in the UIPickerView.
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        
        dataManager.dataModel.requestInterval = Double(pickerData[row])! //Sets the interval amount upon selection to the requestInterval var.
        
    }
    
    
    //Set any additional attributes for each row in the UIPickerView.
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
        let titleData = pickerData[row]
        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 15.0)!,NSForegroundColorAttributeName:UIColor.black])
        
        return myTitle
    }
    //
    
    
}
