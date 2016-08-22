//
//  SecretTableViewCell.swift
//  Funny
//
//  Created by yanzhen on 16/1/8.
//  Copyright (c) 2016年 yanzhen. All rights reserved.
//

import UIKit

class SecretTableViewCell: UITableViewCell {

    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var accountLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var remarksLabel: UILabel!
    
    
    var model: SecretModel! {
        didSet{
            companyLabel.text = model.company;
            accountLabel.text = model.account;
            passwordLabel.text = model.password;
            remarksLabel.text = model.remarks;
        }
    }
}
