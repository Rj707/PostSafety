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
    var nextViewController : UIViewController!
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
        self.setNextViewController()
        
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setNextViewController()
    {
        let storyboard = UIStoryboard(name: "Dashboard_design", bundle: nil)
//        var reportType = ""
//        print(Global.REPORT?.reportType ?? "")
//        reportType = (Global.REPORT?.reportType)!
        switch Global.REPORT?.reportType
        {
        case "Hazard":
            nextViewController = storyboard.instantiateViewController(withIdentifier: "PSSelectLocationViewController") as! PSSelectLocationViewController
        case "NearMiss":
            nextViewController = storyboard.instantiateViewController(withIdentifier: "PSPotentiallySeriousIncidentViewController") as! PSPotentiallySeriousIncidentViewController
        case "Incident":
            nextViewController = storyboard.instantiateViewController(withIdentifier: "PSSelectSubCategoryViewController") as! PSSelectSubCategoryViewController
        default:
            print("")
        }
    }
    
    func getCheckListDetails()
    {
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
    
    // MARK: - IBActions
    
    @IBAction func categoryOneGestureTapped(_ sender: Any)
    {
        Global.REPORT?.reportCategory = "Category 1"
        let dict:[String:String] = ["reportCategory":"Category 1"]
        UserDefaults.standard.set(dict, forKey: "dict")
        navigationController?.pushViewController(nextViewController,
                                                 animated: true)
    }
    @IBAction func categoryTwoGestureTapped(_ sender: Any)
    {
        Global.REPORT?.reportCategory = "Category 2"
        let dict:[String:String] = ["reportCategory":"Category 2"]
        UserDefaults.standard.set(dict, forKey: "dict")
        navigationController?.pushViewController(nextViewController,
                                                 animated: true)
        
    }
    @IBAction func categoryThreeGestureTapped(_ sender: Any)
    {
        Global.REPORT?.reportCategory = "Category 3"
        let dict:[String:String] = ["reportCategory":"Category 3"]
        UserDefaults.standard.set(dict, forKey: "dict")
        navigationController?.pushViewController(nextViewController,
                                                 animated: true)
        
    }
    @IBAction func categoryFourGestureTapped(_ sender: Any)
    {
        Global.REPORT?.reportCategory = "Category 4"
        let dict:[String:String] = ["reportCategory":"Category 4"]
        UserDefaults.standard.set(dict, forKey: "dict")
        navigationController?.pushViewController(nextViewController,
                                                 animated: true)
        
    }
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
