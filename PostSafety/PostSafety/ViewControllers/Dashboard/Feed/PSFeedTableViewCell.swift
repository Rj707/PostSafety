//
//  PSFeedTableViewCell.swift
//  PostSafety
//
//  Created by Rayyan on 07/07/2018.
//  Copyright © 2018 Now Tel. All rights reserved.
//

import UIKit

class PSFeedTableViewCell: UITableViewCell
{

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
   
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
