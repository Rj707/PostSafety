//
//  CategoryTableViewCell.swift
//  PostSafety
//
//  Created by Pasha on 18/05/2018.
//  Copyright © 2018 Now Tel. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var radioButtonView: UIView!
    @IBOutlet weak var catergoryTextField: UITextField!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCell(isselected:Bool , category : String)
 {
    catergoryTextField.text=category
    let bgColor = UIColor.init(red: 235/255.0, green: 235/255.0, blue: 235/255.0, alpha: 1.0)
    if(isselected){
    let myColor = UIColor.black;
    self.radioButtonView.layer.borderColor=myColor.cgColor
    self.radioButtonView.layer.borderWidth=2
         self.radioButtonView.backgroundColor=myColor
        
    }
    else
    {
    let myColor = UIColor.black;
    self.radioButtonView.layer.borderColor=myColor.cgColor
    self.radioButtonView.layer.borderWidth=2
    self.radioButtonView.backgroundColor=bgColor
    }
    }

}
