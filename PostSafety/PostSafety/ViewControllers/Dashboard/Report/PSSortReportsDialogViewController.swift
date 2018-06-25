//
//  PSSortReportsDialogViewController.swift
//  PostSafety
//
//  Created by Rayyan on 25/06/2018.
//  Copyright © 2018 Now Tel. All rights reserved.
//

import UIKit

class PSSortReportsDialogViewController: UIViewController
{

    @IBOutlet weak var view5: UIView!
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view1: UIView!
    
    @IBOutlet weak var reportCategoryDDTextField: IQDropDownTextField!
    @IBOutlet weak var reportSenderDDTextField: IQDropDownTextField!
    @IBOutlet weak var reportTypeDDTextField: IQDropDownTextField!
    @IBOutlet weak var reportStartDateDDTextField: IQDropDownTextField!
    @IBOutlet weak var reportEndDateDDTextField: IQDropDownTextField!
    
    var reportCategoryArray = ["Category 1", "Category 2", "Category 3","Category 4"]
    var reportSenderArray = ["a", "b", "c","d", "e", "f","g", "h", "i"]
    var reportTypeArray = ["Hazard", "Near Miss", "Incident","Emergency"]
    var reportStartDateArray = ["1", "2", "3","4", "5", "6","7", "8", "9"]
    var reportEndDateArray = ["1", "2", "3","4", "5", "6","7", "8", "9"]
    
    var cheklistArray = [Any]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        reportCategoryDDTextField.itemList = reportCategoryArray
        reportSenderDDTextField.itemList = reportSenderArray
        reportTypeDDTextField.itemList = reportTypeArray
        reportStartDateDDTextField.itemList = reportStartDateArray
        reportEndDateDDTextField.itemList = reportEndDateArray
        
        self.view1.layer.borderWidth=1
        self.view2.layer.borderWidth=1
        self.view3.layer.borderWidth=1
        self.view4.layer.borderWidth=1
        self.view5.layer.borderWidth=1
        self.view5.layer.borderColor = UIColor(red:255/255, green:75/255, blue:1/255, alpha: 1).cgColor
        self.view1.layer.borderColor = UIColor(red:255/255, green:75/255, blue:1/255, alpha: 1).cgColor
        self.view2.layer.borderColor = UIColor(red:255/255, green:75/255, blue:1/255, alpha: 1).cgColor
        self.view3.layer.borderColor = UIColor(red:255/255, green:75/255, blue:1/255, alpha: 1).cgColor
        self.view4.layer.borderColor = UIColor(red:255/255, green:75/255, blue:1/255, alpha: 1).cgColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - IBActions
    
    @IBAction func crossButtonTouched(_ sender: UIButton)
    {
        self.dismiss(animated: true)
        {
        }
    }
    
    // MARK: - IBActions
    
    @IBAction func applyFiltersButtonTouched(_ sender: UIButton)
    {
        self.dismiss(animated: true)
        {
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
