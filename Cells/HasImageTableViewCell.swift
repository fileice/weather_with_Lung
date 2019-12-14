//
//  HasImageTableViewCell.swift
//  weather_with_Lung
//
//  Created by CHIOU LI-SHIAU on 2019/12/9.
//  Copyright © 2019 CHIOU LI-SHIAU. All rights reserved.
//

import UIKit

class HasImageTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
