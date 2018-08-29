//
//  CustomParamsTVCell.swift
//  Requestor
//
//  Created by Prosha on 14/11/2015.
//  Copyright © 2015 Prosha Pshenichny Apps. All rights reserved.
//

import UIKit

/// This TableViewCell class represents the Parameters cell.

class CustomParamsTVCell: UITableViewCell {
    

    @IBOutlet weak var keyTextLabelOutlet: UITextField!
    @IBOutlet weak var valueTextLabelOutlet: UITextField!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        keyTextLabelOutlet.borderStyle = UITextBorderStyle.none
        keyTextLabelOutlet.placeholder = "Parameter"
        valueTextLabelOutlet.borderStyle = UITextBorderStyle.none
        valueTextLabelOutlet.placeholder = "Value"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
