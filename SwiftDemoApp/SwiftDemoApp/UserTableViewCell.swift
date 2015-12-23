//
//  UserTableViewCell.swift
//  SwiftDemoApp
//
//  Created by Ferris Li on 12/20/15.
//  Copyright (c) 2015 Ferris Li. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    //MARK: properties
    
    @IBOutlet weak var idLabel: UILabel!
    
    @IBOutlet weak var usernameText: UITextField!
    
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var deleteButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
