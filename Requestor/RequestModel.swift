
//
//  RequestModel.swift
//  Requestor
//
//  Created by Prosha on 06/10/2015.
//  Copyright © 2015 Prosha Pshenichny Apps. All rights reserved.
//

import Foundation
import Alamofire



/// This class performs all of the parsing of the recieved response JSON.

class RequestModel {
    
    
    
    // Alert view properties.
    
    let alertClearTable = UIAlertController.init(title: "Clear Requests", message: "Clear all requests? ", preferredStyle: UIAlertControllerStyle.actionSheet)
    let alertNoConnection = UIAlertController.init(title: "Something went wrong!", message: "Invalid URL or no connection", preferredStyle: UIAlertControllerStyle.alert)
    let alertSelectURL = UIAlertController.init(title: "Seomthing went wrong!", message: "URL was not selected", preferredStyle: UIAlertControllerStyle.alert)
    let alertInvalidURL = UIAlertController.init(title: "Something went wrong!", message: "Invalid URL selected", preferredStyle: UIAlertControllerStyle.alert)
    let alertFinished = UIAlertController.init(title: "Finished!", message: "Requestor has finished working", preferredStyle: UIAlertControllerStyle.alert)
    let alertStopped = UIAlertController.init(title: "Requestor was stopped!", message: "Stopped by the user", preferredStyle: UIAlertControllerStyle.alert)
    let alertActionOK = UIAlertAction.init(title: "OK", style: UIAlertActionStyle.default, handler: nil)
    let alertActionDelete = UIAlertAction.init(title: "DELETE", style: UIAlertActionStyle.destructive, handler: {(alert :UIAlertAction!) in })
    
    
    
    let methods = ["GET": Alamofire.HTTPMethod.get,
                   "POST": Alamofire.HTTPMethod.post,
                   "PUT": Alamofire.HTTPMethod.put,
                   "HEAD": Alamofire.HTTPMethod.head,
                   "PATCH": Alamofire.HTTPMethod.patch,
                   "DELETE": Alamofire.HTTPMethod.delete,
                   "OPTIONS": Alamofire.HTTPMethod.options]
    
    
    
    /// This function is reponsible for making requests and updating the ViewController with the recieved responses, it also stores the response objects in the dataModel which is part of the singletone DataManager.
    
    func makeRequest(_ vc: UIViewController, tbvc: UITableView, dataManager: DataManager, activityIndicatorView: UIActivityIndicatorView) {
        
    

       Alamofire.request(dataManager.dataModel.selectedURLType, method: methods[dataManager.dataModel.HTTPMethod]!, parameters: dataManager.dataModel.parameterDict, encoding: URLEncoding.default, headers:dataManager.dataModel.headersDict )
            .responseJSON { Response in
                
                if Response.response != nil {
                    
                    
                    let convertedDataString = String(data: Response.data!, encoding: String.Encoding.utf8)
                    let responseObject = CustomResponse.init(HTTPResponse: HTTPURLResponse(), HTTPMethod: String(), responseBody: String(), selectedIndex: Int())
                    
                    responseObject.HTTPResponse = Response.response!
                    responseObject.responseBody = convertedDataString!
                    responseObject.HTTPMethod = (Response.request?.httpMethod!)!
                    
                
                    
                    dataManager.dataModel.responseObject.insert(responseObject, at: 0)
                    
                    
                    if dataManager.dataModel.cellCounter.count == 0 {
                        
                        
                        dataManager.dataModel.cellCounter.insert(1, at: 0)
                        
                        
                    } else {
                        
                        
                        dataManager.dataModel.cellCounter.insert(dataManager.dataModel.cellCounter[0] + 1, at: 0)
                    }
                    
                    
                    tbvc.layer.add(self.fadeAnimation(), forKey: nil)
                    tbvc.reloadData()
                    
                    
                } else {
                    
                    
                  
                    self.alertNoConnection.addAction(self.alertActionOK)
                    
                    vc.present(self.alertNoConnection, animated: true, completion: nil)
                    activityIndicatorView.stopAnimating()
                    dataManager.dataModel.barButtonActive = true
                    tbvc.reloadData()
                    
                }
                
            }
        

            ObjectManager.archiveDataManager()
        
        }
    
    
    
    
    /// This function sets up a fade animation and returns it for later use in a VC.
    
    func fadeAnimation() -> CATransition {
        
        
        let fadeAnimation = CATransition()
        fadeAnimation.type = kCATransitionFade
        fadeAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        fadeAnimation.fillMode = kCAFillModeForwards
        fadeAnimation.duration = 0.5
        
        
        return fadeAnimation
    }



}



