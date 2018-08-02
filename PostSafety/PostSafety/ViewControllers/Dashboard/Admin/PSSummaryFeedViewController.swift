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
    @IBOutlet weak var menuButton:UIButton!
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
        self.addMenuAction()
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
        return self.summaryFeedArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var cell:PSFeedTableViewCell
   
        cell = tableView.dequeueReusableCell(withIdentifier: "SummaryFeedCell", for: indexPath) as! PSFeedTableViewCell
        
        let dic = self.summaryFeedArray[indexPath.row] as! NSDictionary
        cell.titleLabel.text = dic["title"] as? String
        cell.dateLabel.text = dic["date"] as? String
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
//        let dic = self.summaryFeedArray[indexPath.row] as! NSDictionary
//        print(Global.USERTYPE?.rawValue ?? "Global None")
//        print(PSDataManager.sharedInstance.loggedInUser?.userType?.rawValue ?? "PSDataManager None")
//        print(PSDataManager.sharedInstance.loggedInUser?.userTypeByRole ?? "PSDataManager RoleNone")
//        if PSDataManager.sharedInstance.loggedInUser?.userTypeByRole == UserType.UserTypeAdmin.rawValue && feedTitle == "Reports"
//        {
//            let storyboard = UIStoryboard(name: "User", bundle: nil)
//            let vc = storyboard.instantiateViewController(withIdentifier: "PSReportPostViewController") as! PSReportPostViewController
//            vc.reportPostDict = self.summaryFeedArray[indexPath.row] as! NSDictionary
//            navigationController?.pushViewController(vc,
//                                                     animated: true)
//        }
//        else if PSDataManager.sharedInstance.loggedInUser?.userTypeByRole == UserType.UserTypeNormal.rawValue && feedTitle == "Reports"
//        {
//            let storyboard = UIStoryboard(name: "User", bundle: nil)
//            let vc = storyboard.instantiateViewController(withIdentifier: "PSReportPostViewController") as! PSReportPostViewController
//            vc.reportPostDict = self.summaryFeedArray[indexPath.row] as! NSDictionary
//            navigationController?.pushViewController(vc,
//                                                     animated: true)
//        }
//        else
//        {
//            let storyboard = UIStoryboard(name: "User", bundle: nil)
//            let vc = storyboard.instantiateViewController(withIdentifier: "PSFeedDetailViewController") as! PSFeedDetailViewController
//            //            vc.feedDetailTitle = self.feedTitleLabel.text!
//            if dic["title"] is NSNull
//            {
//                vc.feedDetailTitle = "None"
//            }
//            else
//            {
//                vc.feedDetailTitle = (dic["title"] as? String)!
//            }
//
//            vc.feedDict = dic
//            navigationController?.pushViewController(vc,
//                                                     animated: true)
//        }
        
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
                    
                let tempArray = dic["array"] as! [Any]

                for checklistDict in tempArray
                {
                    if let tempDict = checklistDict as? [String: Any]
                    {
                        self.summaryFeedArray.append(tempDict)
                    }
                }
                self.summaryFeedTableView.reloadData()
                print(self.summaryFeedArray)
                
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
    
    func addMenuAction()
    {
        if self.revealViewController() != nil
        {
            menuButton.addTarget(self.revealViewController(), action: #selector(self.revealViewController().revealToggle(_:)), for: .touchUpInside)
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
            let menuVC = revealViewController().rearViewController as? MenuViewController
            
            menuVC?.dashboardNavViewController = self.navigationController
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
