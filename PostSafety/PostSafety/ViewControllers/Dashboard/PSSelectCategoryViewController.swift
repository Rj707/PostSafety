//
//  SelectCategoryViewController.swift
//  PostSafety
//
//  Created by Pasha on 18/05/2018.
//  Copyright © 2018 Now Tel. All rights reserved.
//

import UIKit

class PSSelectCategoryViewController: UIViewController
{
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    
    var cheklistDetailsArray = [Any]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.view1.layer.borderWidth=1
        self.view2.layer.borderWidth=1
        self.view3.layer.borderWidth=1
        self.view4.layer.borderWidth=1
        self.backgroundView.layer.borderWidth=1
        self.view1.layer.borderColor = UIColor(red:255/255, green:75/255, blue:1/255, alpha: 1).cgColor
        self.view2.layer.borderColor = UIColor(red:255/255, green:75/255, blue:1/255, alpha: 1).cgColor
        self.view3.layer.borderColor = UIColor(red:255/255, green:75/255, blue:1/255, alpha: 1).cgColor
        self.view4.layer.borderColor = UIColor(red:255/255, green:75/255, blue:1/255, alpha: 1).cgColor
        self.backgroundView.layer.borderColor = UIColor(red:255/255, green:75/255, blue:1/255, alpha: 1).cgColor
        
        PSAPIManager.sharedInstance.checklistManagerAPI.getChecklistDetailsWith(checkListID: "10002",
        success:
        { (dic:Dictionary<String,Any>) in
            
            let tempArray = dic["array"] as! [Any]
            
            for checklistDetailDict in tempArray
            {
                //                            if let dict = peopleDict as? [String: Any], let peopleArray = dict["People"] as? [String]
                if let tempDict = checklistDetailDict as? [String: Any]
                {
                    var checklistDetail = PSChecklistDetail()
                    checklistDetail = checklistDetail.initWithDictionary(dict: tempDict as NSDictionary)
                    self.cheklistDetailsArray.append(checklistDetail)
                }
            }
            print(self.cheklistDetailsArray)
        },
        failure:
        { (error, statusCode) in
            
        }, errorPopup: true)
        
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - IBActions
    
    @IBAction func backButtonTouched(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
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
