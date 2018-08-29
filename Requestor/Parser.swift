//
//  Parser.swift
//  Requestor
//
//  Created by Prosha on 06/10/2015.
//  Copyright © 2015 Prosha Pshenichny Apps. All rights reserved.
//

import Foundation
import Alamofire



/// This class performs all of the parsing of the recieved response JSON to be represnted in the VC.

class ParseRequest {
    
    var host_adress: String
    
    
    init(host_adress: String) {
    self.host_adress = host_adress
        
    }
   
    
    /// Returns the URL of the response.
    func parseHTTPURL(_ responseJson: String) -> String {
        
        let workString = responseJson
        var urlString = ""
        urlString = workString.components(separatedBy: "URL: ")[1].components(separatedBy: "}")[0].components(separatedBy: "//")[1].components(separatedBy: "/")[0]
    
        return urlString
        
    }
    
    /// Returns the status code of the response.
    func parseHTTPStatusCode(_ responseJson: String) -> String {
        
        let workString = responseJson
        var statusCodeString = ""
        
        statusCodeString = workString.components(separatedBy: " status code:")[0]
        statusCodeString = String(statusCodeString.dropFirst())
        
        return statusCodeString
        
    }
    
    /// Returns the Date of the response.
    func parseHTTPResponseDate(_ responseJson: String) -> String {
        
        let workString = responseJson
        var dateString = ""
        
    
        dateString = workString.components(separatedBy: "Date = ")[1].components(separatedBy: ";")[0].components(separatedBy: ",")[1].components(separatedBy: "\n")[0]
        dateString = String(dateString.dropFirst())
        dateString = String(dateString.dropLast())

       return dateString
    }
    
    
    /// Returns the headers of the response.
    func headersParse(_ responseJson: String) -> String {
        
        let workingString = responseJson
        var headerString = ""
    
        headerString = workingString.components(separatedBy: "headers {")[1]
     
        let newHeaderString = headerString.components(separatedBy: ";")
        
        headerString.removeAll()
        for item in newHeaderString {
            
            headerString += item
            
        }
    
        return headerString
        
    }
    
    

    
}
            




        
        

    
    
