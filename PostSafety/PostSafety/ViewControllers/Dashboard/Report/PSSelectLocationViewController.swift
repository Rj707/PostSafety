//
//  SelectLocationViewController.swift
//  PostSafety
//
//  Created by Hafiz Saad on 16/05/2018.
//  Copyright © 2018 Now Tel. All rights reserved.
//

import UIKit

class PSSelectLocationViewController: UIViewController
{
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    
    @IBOutlet weak var stackView1: UIStackView!
    @IBOutlet weak var stackView2: UIStackView!
    @IBOutlet weak var stackView3: UIStackView!
    @IBOutlet weak var stackView4: UIStackView!
    
    @IBOutlet weak var label4: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label1: UILabel!
    
    var locationsArray = [Any]()
    var companyId = 0
    var locationselected:Bool=false
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.getLocationsforReport()
        
        self.stackView1.isHidden = true
        self.stackView2.isHidden = true
        self.stackView3.isHidden = true
        self.stackView4.isHidden = true
        
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

    }

    func getLocationsforReport() -> Void
    {
        if CEReachabilityManager.isReachable()
        {
            PSUserInterfaceManager.sharedInstance.showLoaderWithText(text: "Fetching Locations")
            companyId = (PSDataManager.sharedInstance.loggedInUser?.companyId)!
            PSAPIManager.sharedInstance.getLocationsFor(companyId: String(companyId) ,success:
            { (dic) in
                PSUserInterfaceManager.sharedInstance.hideLoader()
                let tempArray = dic["array"] as! [Any]
                
                for checklistDict in tempArray
                {
                    if let tempDict = checklistDict as? [String: Any]
                    {
                        self.locationsArray.append(tempDict)
                    }
                }
                
                self.configureLocations()
                print(self.locationsArray)
                
            }, failure:
                
            {
                (error:NSError,statusCode:Int) in
                PSUserInterfaceManager.sharedInstance.hideLoader()
                if(statusCode==404)
                {
                    PSUserInterfaceManager.showAlert(title: "Locations", message: ApiResultFailureMessage.InvalidEmailPassword)
                }
                else
                {
                    
                }
                
            }, errorPopup: true)
        }
    }
    
    func configureLocations() -> Void
    {
        for i in 0...self.locationsArray.count-1
        {
            var item = NSDictionary()
            item = locationsArray[i] as! NSDictionary
            
            switch i
            {
                case 0  :
                    self.stackView1.isHidden = false
                    self.label1.text = item["branchAddress"] as? String
                    self.label1.tag = (item["branchId"] as? Int)!
                case 1  :
                    self.stackView2.isHidden = false
                    self.label2.text = item["branchAddress"] as? String
                    self.label2.tag = (item["branchId"] as? Int)!
                case 2  :
                    self.stackView3.isHidden = false
                    self.label3.text = item["branchAddress"] as? String
                    self.label3.tag = (item["branchId"] as? Int)!
                default :
                    self.stackView4.isHidden = false
                    self.label4.text = item["branchAddress"] as? String
                    self.label4.tag = (item["branchId"] as? Int)!
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - IBActions
    
    @IBAction func backButtonTouched(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func locationOneGestureTapped(_ sender: Any)
    {
        Global.REPORT?.reportLocation = self.label1.text
        locationselected = true
        var result:[String:String] = (UserDefaults.standard.value(forKey: "dict") as? [String : String])!
        result["location"] = self.label1.text
        UserDefaults.standard.set(result, forKey: "dict")
        self.performSegue(withIdentifier: "toReportSummaryFromLocation", sender: self.label1.tag)
    }
    @IBAction func locationTwoGestureTapped(_ sender: Any)
    {
        Global.REPORT?.reportLocation = self.label2.text
        locationselected=true
        var result:[String:String] = (UserDefaults.standard.value(forKey: "dict") as? [String : String])!
        result["location"] = self.label2.text
        UserDefaults.standard.set(result, forKey: "dict")
        self.performSegue(withIdentifier: "toReportSummaryFromLocation", sender: self.label2.tag)
    }
    @IBAction func locationThreeGestureTapped(_ sender: Any)
    {
        Global.REPORT?.reportLocation = self.label3.text
        locationselected=true
        var result:[String:String] = (UserDefaults.standard.value(forKey: "dict") as? [String : String])!
        result["location"] = self.label3.text
        UserDefaults.standard.set(result, forKey: "dict")
        self.performSegue(withIdentifier: "toReportSummaryFromLocation", sender: self.label3.tag)
    }
    @IBAction func locationFourGestureTapped(_ sender: Any)
    {
        Global.REPORT?.reportLocation = self.label4.text
        locationselected=true
        var result:[String:String] = (UserDefaults.standard.value(forKey: "dict") as? [String : String])!
        result["location"] = self.label4.text
        UserDefaults.standard.set(result, forKey: "dict")
        self.performSegue(withIdentifier: "toReportSummaryFromLocation", sender: self.label4.tag)
    }
 
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let summaryVC = segue.destination as! PSReportSummaryViewController
        summaryVC.locationID = sender as! Int
    }
 

}
