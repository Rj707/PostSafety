//
//  SummaryStatsHomeViewController.swift
//  PostSafety
//
//  Created by Pasha on 24/06/2018.
//  Copyright © 2018 Now Tel. All rights reserved.
//

import UIKit

class PSSummaryStatsHomeViewController: UIViewController
{

    @IBOutlet weak var yesterdayView: UIView!
    @IBOutlet weak var monthView: UIView!
    @IBOutlet weak var yearView: UIView!
    
    @IBOutlet weak var yesterdayReportLabel: UILabel!
    @IBOutlet weak var monthReportLabel: UILabel!
    @IBOutlet weak var yearReportLabel: UILabel!
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    
    var companyId = 0
    var summaryStatsArray = [Any]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.getSummaryStatsCount()
        self.yesterdayView.layer.borderWidth=2
        self.monthView.layer.borderWidth=2
        self.yearView.layer.borderWidth=2
      
        self.yesterdayView.layer.borderColor = UIColor(red:255/255, green:75/255, blue:1/255, alpha: 1).cgColor
        self.monthView.layer.borderColor = UIColor(red:255/255, green:75/255, blue:1/255, alpha: 1).cgColor
        self.yearView.layer.borderColor = UIColor(red:255/255, green:75/255, blue:1/255, alpha: 1).cgColor
        
        self.view1.layer.borderWidth=2
        self.view2.layer.borderWidth=2
        self.view3.layer.borderWidth=2
        
        self.view1.layer.borderColor = UIColor(red:255/255, green:75/255, blue:1/255, alpha: 1).cgColor
        self.view2.layer.borderColor = UIColor(red:255/255, green:75/255, blue:1/255, alpha: 1).cgColor
        self.view3.layer.borderColor = UIColor(red:255/255, green:75/255, blue:1/255, alpha: 1).cgColor
        
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getSummaryStatsCount()
    {
        if CEReachabilityManager.isReachable()
        {
            PSUserInterfaceManager.sharedInstance.showLoaderWithText(text: "Fetching Statistics")
            companyId = (PSDataManager.sharedInstance.loggedInUser?.companyId)!
            PSAPIManager.sharedInstance.getStatictisCount(companyId: String(companyId), success:
                { (dic) in
                    PSUserInterfaceManager.sharedInstance.hideLoader()
//                    let tempArray = dic["array"] as! [Any]
//
//                    for checklistDict in tempArray
//                    {
//                        if let tempDict = checklistDict as? [String: Int]
//                        {
//                            self.summaryStatsArray.append(tempDict)
//                        }
//                    }
                    
                    var tempDict = dic["yesterday"] as! [String: Int]
                    self.summaryStatsArray.append(tempDict)
                    tempDict = dic["year"] as! [String: Int]
                    self.summaryStatsArray.append(tempDict)
                    tempDict = dic["thisMonth"] as! [String: Int]
                    self.summaryStatsArray.append(tempDict)
                    
                    
                    for i in 0...self.summaryStatsArray.count-1
                    {
                        var item = NSDictionary()
                        item = self.summaryStatsArray[i] as! NSDictionary
                        switch i
                        {
                        case 0:
                            print(item["totalReports"] ?? "None0")
                            self.yesterdayReportLabel.text = String(item["totalReports"] as! Int)
                            break
                        case 1:
                            print(item["totalReports"] as? String ?? "None1")
                            self.monthReportLabel.text = String(item["totalReports"] as! Int)
                            break
                        default:
                            print(item["totalReports"] as? String ?? "NoneDefault")
                            self.yearReportLabel.text = String(item["totalReports"] as! Int)
                        }
                    }
                    
                    print(self.summaryStatsArray)
                    
            }, failure:
                { (error:NSError,statusCode:Int) in
                    
                    PSUserInterfaceManager.sharedInstance.hideLoader()
                    if(statusCode==404)
                    {
                        PSUserInterfaceManager.showAlert(title: "Checklist", message: ApiResultFailureMessage.InvalidEmailPassword)
                    }
                    else
                    {
                        
                    }
                    
            }, errorPopup: true)
        }
    }
    
    // MARK: - IBActions
    
    @IBAction func yesterdayGestureTapped(_ sender: Any)
    {
        let storyboard = UIStoryboard(name: "Admin", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PSCategorySelectViewController") as! PSCategorySelectViewController
        vc.summaryStatisticsTitle = "Yesterday's "
        vc.summaryStatisticsDict = self.summaryStatsArray[0] as! NSDictionary
        navigationController?.pushViewController(vc,
                                                 animated: true)
    }
    @IBAction func thisMonthGestureTapped(_ sender: Any)
    {
        let storyboard = UIStoryboard(name: "Admin", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PSCategorySelectViewController") as! PSCategorySelectViewController
        vc.summaryStatisticsTitle = "This Month's "
        vc.summaryStatisticsDict = self.summaryStatsArray[1] as! NSDictionary
        navigationController?.pushViewController(vc,
                                                 animated: true)
    }
    @IBAction func yearToDateGestureTapped(_ sender: Any)
    {
        let storyboard = UIStoryboard(name: "Admin", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PSCategorySelectViewController") as! PSCategorySelectViewController
        vc.summaryStatisticsTitle = "Year To Date's "
        vc.summaryStatisticsDict = self.summaryStatsArray[2] as! NSDictionary
        navigationController?.pushViewController(vc,
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
