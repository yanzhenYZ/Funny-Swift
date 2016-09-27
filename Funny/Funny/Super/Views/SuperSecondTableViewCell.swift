//
//  SuperSecondTableViewCell.swift
//  Funny
//
//  Created by yanzhen on 15/12/22.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

import UIKit

class SuperSecondTableViewCell: UITableViewCell {

    @IBOutlet weak var bottomSecondImageView: UIImageView!
    @IBOutlet weak var titleSecondLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
