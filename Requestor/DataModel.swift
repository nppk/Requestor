//
//  DataModel.swift
//  Requestor
//
//  Created by Prosha on 06/10/2015.
//  Copyright © 2015 Prosha Pshenichny Apps. All rights reserved.
//

import Foundation


/// This class is responsible for data persistancy of the app, storing all the settings/saved data. 

class DataModel:NSObject, NSCoding{
    
    // Settings properties
    
    var headersDict:[String: String]
    var headersDictTableViewDisplay:[String]
    var parameterDict: [String: String]
    var selectedRequestType: String
    var HTTPMethod: String
    var numberOfRequests: Int
    var requestInterval: Double
    var selectedURL: Int
    var selectedURLType: String
    
    // Structure properties
    
    var url_rows: [String]
    var barButtonActive: Bool
    
    // DataModel properties
    
    var cellCounter: [Int]
    var responseObject: [CustomResponse]
    var responseArchive: [CustomResponse]
    var selectedIndex: Int
    
  
    init(headersDict: [String: String], headersDictTableViewDisplay:[String], parameterDict: [String: String], selectedRequestType: String, HTTPMethod: String, numberOfRequests: Int,requestInterval: Double, selectedURL: Int, selectedURLType: String, url_rows: [String], barButtonActive: Bool, cellCounter: [Int], responseObject: [CustomResponse], responseArchive: [CustomResponse], selectedIndex: Int) {
        
        
        self.headersDict = headersDict
        self.headersDictTableViewDisplay = headersDictTableViewDisplay
        self.parameterDict = parameterDict
        self.selectedRequestType = selectedRequestType
        self.HTTPMethod = HTTPMethod
        self.numberOfRequests = numberOfRequests
        self.requestInterval = requestInterval
        self.selectedURL = selectedURL
        self.selectedURLType = selectedURLType
        self.url_rows = url_rows
        self.barButtonActive = barButtonActive
        self.cellCounter = cellCounter
        self.responseObject = responseObject
        self.responseArchive = responseArchive
        self.selectedIndex = selectedIndex
        
        super.init()
    }

    

    
    required convenience init?(coder decoder: NSCoder) {
        
        guard let headersDict = decoder.decodeObject(forKey: "headersDict") as? [String :String],
              let headersDictTableViewDisplay = decoder.decodeObject(forKey: "headersDictTableViewDisplay") as? [String],
              let parameterDict = decoder.decodeObject(forKey: "parameterDict") as? [String: String],
              let selectedRequestType = decoder.decodeObject(forKey: "selectedRequestType") as? String,
              let HTTPMethod = decoder.decodeObject(forKey: "HTTPMethod") as? String,
              let numberOfRequests = decoder.decodeInteger(forKey: "numberOfRequests") as? Int,
              let requestInterval = decoder.decodeDouble(forKey: "requestInterval") as? Double,
              let selectedURL = decoder.decodeInteger(forKey: "selectedURL") as? Int,
              let selectedURLType = decoder.decodeObject(forKey: "selectedURLType") as? String,
              let url_rows = decoder.decodeObject(forKey: "url_rows") as? [String],
              let barButtonActive = decoder.decodeBool(forKey: "barButtonActive") as? Bool,
              let cellCounter = decoder.decodeObject(forKey: "cellCounter") as? [Int],
              let responseObject = decoder.decodeObject(forKey: "responseObject") as? [CustomResponse],
              let responseArchive = decoder.decodeObject(forKey: "responseArchive") as? [CustomResponse],
              let selectedIndex = decoder.decodeInteger(forKey: "selectedIndex") as? Int
        
        
            
            
        else { return nil }
        
        self.init(
            
            headersDict: headersDict,
            headersDictTableViewDisplay: headersDictTableViewDisplay,
            parameterDict: parameterDict,
            selectedRequestType: selectedRequestType,
            HTTPMethod: HTTPMethod,
            numberOfRequests: numberOfRequests,
            requestInterval: requestInterval,
            selectedURL: selectedURL,
            selectedURLType: selectedURLType,
            url_rows: url_rows,
            barButtonActive: barButtonActive,
            cellCounter: cellCounter,
            responseObject: responseObject,
            responseArchive: responseArchive,
            selectedIndex: selectedIndex
    
        )
    }
    
    
 
    

    
    func encode(with coder: NSCoder) {
        
        coder.encode(self.headersDict, forKey: "headersDict")
        coder.encode(self.headersDictTableViewDisplay, forKey: "headersDictTableViewDisplay")
        coder.encode(self.parameterDict, forKey: "parameterDict")
        coder.encode(self.selectedRequestType, forKey: "selectedRequestType")
        coder.encode(self.HTTPMethod, forKey: "HTTPMethod")
        coder.encode(self.numberOfRequests, forKey: "numberOfRequests")
        coder.encode(self.requestInterval, forKey: "requestInterval")
        coder.encode(self.selectedURL, forKey: "selectedURL")
        coder.encode(self.selectedURLType, forKey: "selectedURLType")
        coder.encode(self.url_rows, forKey: "url_rows")
        coder.encode(self.barButtonActive, forKey: "barButtonActive")
        coder.encode(self.cellCounter, forKey: "cellCounter")
        coder.encode(self.responseObject, forKey: "responseObject")
        coder.encode(self.responseArchive, forKey: "responseArchive")
        coder.encode(self.selectedIndex, forKey: "selectedIndex")
        

        
        
    }
    
    
    
    
    
}
