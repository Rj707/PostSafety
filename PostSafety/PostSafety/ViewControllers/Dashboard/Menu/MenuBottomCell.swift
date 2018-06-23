//
//  MenuBottomCell.swift
//  AppFlow
//
//  Created by Mati ur Rab on 12/7/17.
//  Copyright © 2017 Mati Ur Rab. All rights reserved.
//

import UIKit

class MenuBottomCell: UITableViewCell {

    @IBOutlet weak var selectedRowBg: UIImageView!
    @IBOutlet weak var rowIconImage: UIImageView!
    @IBOutlet weak var rowTitleLbl: UILabel!
    @IBOutlet weak var selectedRowIndicator: UIView!
    
    var rowSelected:Bool = false
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
