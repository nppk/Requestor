//
//  CustomResponse.swift
//  Requestor
//
//  Created by Prosha on 07/12/2015.
//  Copyright © 2017 Prosha Pshenichny Apps. All rights reserved.
//

import Foundation



/// This class represnts a custom response for convinient storage and display of it's data.

class CustomResponse:NSObject, NSCoding{
    
    var HTTPResponse: HTTPURLResponse
    var HTTPMethod: String
    var responseBody: String
    var selectedIndex: Int
    
    

    
    init(HTTPResponse: HTTPURLResponse, HTTPMethod: String, responseBody: String, selectedIndex: Int) {
        
        
        self.HTTPResponse = HTTPResponse
        self.HTTPMethod = HTTPMethod
        self.responseBody = responseBody
        self.selectedIndex = selectedIndex
        
        super.init()
    }
    
    
    
    
    required convenience init?(coder decoder: NSCoder) {
        
        guard let HTTPResponse = decoder.decodeObject(forKey: "HTTPResponse") as? HTTPURLResponse,
            let HTTPMethod = decoder.decodeObject(forKey: "HTTPMethod") as? String,
            let responseBody = decoder.decodeObject(forKey: "responseBody") as? String,
            let selectedIndex = decoder.decodeInteger(forKey: "selectedIndex") as? Int
     
            
            
            else { return nil }
        
        self.init(
            
            HTTPResponse: HTTPResponse,
            HTTPMethod: HTTPMethod,
            responseBody: responseBody,
            selectedIndex: selectedIndex
          
            
        )
    }
    
    
    
    
    
    func encode(with coder: NSCoder) {
        
        coder.encode(self.HTTPResponse, forKey: "HTTPResponse")
        coder.encode(self.HTTPMethod, forKey: "HTTPMethod")
        coder.encode(self.responseBody, forKey: "responseBody")
        coder.encode(self.selectedIndex, forKey: "selectedIndex")
      
        
        
    
    }
    
    
    
    
        
}
