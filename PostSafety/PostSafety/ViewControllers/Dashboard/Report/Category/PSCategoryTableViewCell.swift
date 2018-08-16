//
//  PSCategoryTableViewCell.swift
//  PostSafety
//
//  Created by Rayyan on 17/07/2018.
//  Copyright © 2018 Now Tel. All rights reserved.
//

import UIKit

class PSCategoryTableViewCell: UITableViewCell
{
    @IBOutlet weak var categoryTitleLabel: UILabel!
    @IBOutlet weak var mainView: UIView!
    var data : NSDictionary = [:]
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
        self.mainView.layer.borderWidth=1
        self.mainView.layer.borderColor = UIColor(red:255/255, green:75/255, blue:1/255, alpha: 1).cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
