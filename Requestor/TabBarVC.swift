//
//  TabBarVC.swift
//  Requestor
//
//  Created by Prosha on 08/11/2015.
//  Copyright © 2015 Prosha Pshenichny Apps. All rights reserved.
//

import UIKit

class TabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Cuztomizes the tab bar appearance.
        
        UITabBar.appearance().tintColor = UIColor.orange
      
        UITabBar.appearance().barTintColor = UIColor.white
        UITabBar.appearance().backgroundColor = UIColor.orange
        UITabBar.appearance().barTintColor = UIColor.groupTableViewBackground
        self.selectedIndex = 2
        
        //
        
        // Sets the initial viewController to be displayed upon load.
        
        
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
