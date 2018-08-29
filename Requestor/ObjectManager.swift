//
//  ObjectManager.swift
//  Requestor
//
//  Created by Prosha on 06/10/2015.
//  Copyright © 2015 Prosha Pshenichny Apps. All rights reserved.


import Foundation
import Alamofire



/// This class archives/unarchives the singletone dataManager with NSUserDefaults.

class ObjectManager {
  
    
    let defaultsManager = UserDefaults.standard
    
    
    // Returns the URL of the response.
    
    static func archiveDataManager()  {
        
        let defaultsManager = UserDefaults.standard
        let key = "dataModel"
        let object = DataManager.sharedInstance.dataModel
        let objectData: Data = NSKeyedArchiver.archivedData(withRootObject: object)
        
    
        defaultsManager.set(objectData, forKey: key)
        defaultsManager.synchronize()
    
        
        

    }
    
    
    
    /// Unarchives the dataModel object and assigns it to the singletone model property.
    
    static func unarchiveDataModel() {
        
        
        let defaultsManager = UserDefaults.standard
        
        
        if (checkIfModelExists()) {
            
            let objectData = defaultsManager.object(forKey: "dataModel") as! Data
            let decodedDataManager = NSKeyedUnarchiver.unarchiveObject(with: objectData) as! DataModel
            
            
            DataManager.sharedInstance.dataModel = decodedDataManager
            
            
        }
        
        
    }
    
    
    
    /// Remove object for a key String from nsuserDefaults.
    
    func remobeObjectFromNSUserDefaults(_ key: String) {
        
        defaultsManager.removeObject(forKey: key)
        defaultsManager.synchronize()
        
        
        
    }
    
   
    
    /// This function checks if the data model is already stored on the disk returns true or false.
    
    static func checkIfModelExists() ->Bool {
        
        let defaultsManager = UserDefaults.standard
        
        var modelStatus = Bool()
        
        if (defaultsManager.value(forKey: "dataModel") != nil) {
            
            modelStatus = true
            
        } else {
            
            modelStatus = false
        }
        
        return modelStatus
    }
    
    
    
}
