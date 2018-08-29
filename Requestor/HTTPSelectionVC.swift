
//  Created by Prosha Pshenichny on 27/11/2017.
//  Copyright © 2017 Prosha Pshenichny Apps. All rights reserved.
//

import UIKit

/// This VC class is responsible for the selection of the desired HTTP method.

class HTTPSelectionVC: UITableViewController {
    
    let httpMethods = ["GET", "POST", "PUT", "HEAD", "OPTIONS", "PATCH", "DELETE"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        dataManager.dataModel.selectedRequestType = httpMethods[(indexPath as NSIndexPath).row]
        dataManager.dataModel.HTTPMethod = httpMethods[(indexPath as NSIndexPath).row]
        ObjectManager.archiveDataManager()
        
    
        self.navigationController?.popToRootViewController(animated: true)
    }
    



}
