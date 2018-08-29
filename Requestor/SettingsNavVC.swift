//
//  SettingsNavVC.swift
//  Requestor
//
//  Created by Prosha on 08/11/2015.
//  Copyright © 2015 Prosha Pshenichny Apps. All rights reserved.
//

import UIKit

class SettingsNavVC: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        UINavigationBar.appearance().barTintColor = UIColor.orange
        UINavigationBar.appearance().tintColor = UIColor.white
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
