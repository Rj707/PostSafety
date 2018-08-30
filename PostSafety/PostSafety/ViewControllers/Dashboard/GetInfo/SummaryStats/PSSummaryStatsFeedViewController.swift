//
//  SummaryFeedViewController.swift
//  PostSafety
//
//  Created by Pasha on 24/06/2018.
//  Copyright © 2018 Now Tel. All rights reserved.
//

import UIKit

class PSSummaryStatsFeedViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate
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
        self.summaryFeedTableView.tableFooterView = UIView.init()
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
    
        cell.titleLabel.text = String(format: "%@ : %@", (dic["incidentType"] as? String)!,(dic["catagory"] as? String)!)
        cell.titleLabel.text =  cell.titleLabel.text?.components(separatedBy: .newlines).joined()
        cell.dateLabel.text = dic["date"] as? String
        cell.timeLabel.text = dic["time"] as? String
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let dic = self.summaryFeedArray[indexPath.row] as! NSDictionary
        
        var cell:PSFeedTableViewCell
        cell = tableView.cellForRow(at: indexPath) as! PSFeedTableViewCell
        
        PSDataManager.sharedInstance.reportId = dic["reportId"] as! Int
        let storyboard = UIStoryboard(name: "User", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PSPostedReportViewController") as! PSPostedReportViewController
        vc.reportPostDict = self.summaryFeedArray[indexPath.row] as! NSDictionary
        vc.postTitle =  cell.titleLabel.text!
        navigationController?.pushViewController(vc,
                                                 animated: true)
    }
    
    //MARK: - APIs
    
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
                self.summaryFeedTableView.emptyDataSetSource = self as DZNEmptyDataSetSource
                self.summaryFeedTableView.emptyDataSetDelegate = self as DZNEmptyDataSetDelegate
                self.summaryFeedTableView.reloadData()
                print(self.summaryFeedArray)
                
            }, failure:
                { (error:NSError,statusCode:Int) in
                    
                    PSUserInterfaceManager.sharedInstance.hideLoader()
                    if(statusCode==404)
                    {
                        PSUserInterfaceManager.showAlert(title: "Fetching Statistics Detail", message: ApiErrorMessage.ErrorOccured)
                    }
                    else
                    {
                        PSUserInterfaceManager.showAlert(title: "Fetching Statistics Detail", message: error.localizedDescription)
                    }
                    
            }, errorPopup: true)
        }
    }
    
    func addMenuAction()
    {
        if self.revealViewController() != nil
        {
            menuButton.addTarget(self.revealViewController(), action: #selector(self.revealViewController().rightRevealToggle(_:)), for: .touchUpInside)
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
            let menuVC = revealViewController().rearViewController as? MenuViewController
            
            menuVC?.dashboardNavViewController = self.navigationController
        }
    }
    
    //MARK: - DZNEmptyDataSetSource
    
    func image(forEmptyDataSet scrollView: UIScrollView?) -> UIImage?
    {
        return UIImage(named: "no_data")
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView?) -> NSAttributedString?
    {
        let myString = "No Data found!"
        //        let attributes = [NSFontAttributeName : UIFont.systemFont(ofSize: 19.0),NSForegroundColorAttributeName : UIColor(red: 255, green: 75, blue: 1, alpha: 1.0) ]
        let attributes = [NSFontAttributeName : UIFont.systemFont(ofSize: 19.0),NSForegroundColorAttributeName : UIColor.red ]
        let myAttrString = NSAttributedString(string: myString, attributes: attributes)
        return myAttrString
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
