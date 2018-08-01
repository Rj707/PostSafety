//
//  SummaryFeedViewController.swift
//  PostSafety
//
//  Created by Pasha on 24/06/2018.
//  Copyright © 2018 Now Tel. All rights reserved.
//

import UIKit

class PSSummaryFeedViewController: UIViewController,UITableViewDataSource,UITableViewDelegate
{

    @IBOutlet weak var summaryFeedTableView : UITableView!
    @IBOutlet weak var summaryFeedTitleLabel : UILabel!
    
    var summaryFeedTitle: String = ""
    var IncidentType: String = ""
    var DateType: String = ""
    var companyId = 0
    var summaryFeedArray = [Any]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.summaryFeedTableView.dataSource = self
        self.summaryFeedTableView.delegate = self
        summaryFeedTitleLabel.text =  summaryFeedTitle
        self.getSummaryStatsDetail()
        
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
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var cell:UITableViewCell
        
        cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath)
        
        return cell
    }
    
    func getSummaryStatsDetail()
    {
        if CEReachabilityManager.isReachable()
        {
            PSUserInterfaceManager.sharedInstance.showLoaderWithText(text: "Fetching Statistics Detail")
            companyId = (PSDataManager.sharedInstance.loggedInUser?.companyId)!
            PSAPIManager.sharedInstance.getSummaryStatisticsReportsWith(companyId: String(companyId),DateType: DateType,IncidentType: IncidentType, success:
            { (dic) in
                
                PSUserInterfaceManager.sharedInstance.hideLoader()
                    
//                    //                    let tempArray = dic["array"] as! [Any]
//                    //
//                    //                    for checklistDict in tempArray
//                    //                    {
//                    //                        if let tempDict = checklistDict as? [String: Int]
//                    //                        {
//                    //                            self.summaryStatsArray.append(tempDict)
//                    //                        }
//                    //                    }
//
//                    var tempDict = dic["yesterday"] as! [String: Int]
//                    self.summaryStatsArray.append(tempDict)
//                    tempDict = dic["year"] as! [String: Int]
//                    self.summaryStatsArray.append(tempDict)
//                    tempDict = dic["thisMonth"] as! [String: Int]
//                    self.summaryStatsArray.append(tempDict)
//
//
//                    for i in 0...self.summaryStatsArray.count-1
//                    {
//                        var item = NSDictionary()
//                        item = self.summaryStatsArray[i] as! NSDictionary
//                        switch i
//                        {
//                        case 0:
//                            print(item["totalReports"] ?? "None0")
//                            self.yesterdayReportLabel.text = String(item["totalReports"] as! Int)
//                            break
//                        case 1:
//                            print(item["totalReports"] as? String ?? "None1")
//                            self.monthReportLabel.text = String(item["totalReports"] as! Int)
//                            break
//                        default:
//                            print(item["totalReports"] as? String ?? "NoneDefault")
//                            self.yearReportLabel.text = String(item["totalReports"] as! Int)
//                        }
//                    }
//
//                    print(self.summaryStatsArray)
                    
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
