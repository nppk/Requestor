//
//  RequestTVCell.swift
//  Requestor
//
//  Created by Prosha on 11/11/2015.
//  Copyright © 2015 Prosha Pshenichny Apps. All rights reserved.
//

import UIKit

/// This is a custom TableViewCell to present the Request object.

class RequestTVCell: UITableViewCell {

    @IBOutlet weak var methodImageView: UIImageView!
    @IBOutlet weak var titleLabelOutlet: UILabel!
    @IBOutlet weak var additionalInfoLabelOutlet: UILabel!
    @IBOutlet weak var dateLabelOutlet: UILabel!
    @IBOutlet weak var numberOfRequestsLabelOutlet: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
