//
//  Data.swift
//  Requestor
//
//  Created by Prosha on 06/10/2015.
//  Copyright © 2015 Prosha Pshenichny Apps. All rights reserved.


import UIKit


///* This singletone class is responsible for data persistancy of the app,
///  Stores the property dataModel, which is responsibe for storing all the nessasry requests and option settings app,




class DataManager: NSObject {
    
    // MARK: - Shared Instance
    
     var dataModel = DataModel.init(headersDict: [String:String](), headersDictTableViewDisplay: [String](), parameterDict: [String: String](), selectedRequestType: String(), HTTPMethod: String(), numberOfRequests: 1, requestInterval: 0.1 ,selectedURL: Int(), selectedURLType: String(), url_rows: ["https://apple.com"], barButtonActive: true, cellCounter: [Int](), responseObject: [CustomResponse](), responseArchive: [CustomResponse](), selectedIndex: Int())
    
    
    static let sharedInstance: DataManager = {
        let instance = DataManager()
        // setup code
        return instance
    }()
    
    // MARK: - Initialization Method
    
    override init() {
        super.init()
    }
}



    

