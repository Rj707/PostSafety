//
//  UpdatesAnnouncementsViewController.swift
//  PostSafety
//
//  Created by Hafiz Saad on 16/05/2018.
//  Copyright © 2018 Now Tel. All rights reserved.
//

enum FeedType :Int
{
    case Announcement
    case SharedReports
}

import UIKit



class PSFeedViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,PSSortReportsDialogViewControllerDelegate,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate

{
    
    @IBOutlet weak var unOpenedView: UIView!
    @IBOutlet weak var archivedView: UIView!
    
    @IBOutlet weak var sharedReportsView: UIView!
    @IBOutlet weak var myReportsView: UIView!
    @IBOutlet weak var allReportsView: UIView!
    
    @IBOutlet weak var filterReportsView: UIView!
    @IBOutlet weak var reportsStackView: UIStackView!
    
    @IBOutlet weak var updatesAnnouncementsTableView : UITableView!
    @IBOutlet weak var feedTitleLabel: UILabel!
    @IBOutlet weak var menuButton:UIButton!
    
    var feedTitle: String = ""
    var route: String = ""
    var companyId = 0
    var type : FeedType!
    var feedArray = [Any]()
    var feedArray2 = Array<Any>()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.addMenuAction()
        self.updatesAnnouncementsTableView.tableFooterView = UIView.init()
        
        self.type = FeedType.init(rawValue: 0)
        self.updatesAnnouncementsTableView.dataSource = self
        self.updatesAnnouncementsTableView.delegate = self
        self.feedTitleLabel.text = self.feedTitle
        
        if PSDataManager.sharedInstance.loggedInUser?.userTypeByRole == UserType.UserTypeAdmin.rawValue && feedTitle == "Reports"
        {
            self.filterReportsView.isHidden = false
            self.reportsStackView.isHidden = false
        }
        else
        {
            self.filterReportsView.isHidden = true
            self.reportsStackView.isHidden = true
        }
        
        if feedTitle == "Alerts" || feedTitle == "Announcements" || feedTitle == "Safety Updates"
        {
            
        }
        else
        {
            self.getInfoFor()
        }
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getInfoFor()
    {
        if CEReachabilityManager.isReachable()
        {
            PSUserInterfaceManager.sharedInstance.showLoaderWithText(text: String(format: "%@%@", "Fetching ", self.feedTitle))
            companyId = (PSDataManager.sharedInstance.loggedInUser?.companyId)!
            PSAPIManager.sharedInstance.getInfoFor(companyId: String(companyId), route: route ,success:
            { (dic) in
                PSUserInterfaceManager.sharedInstance.hideLoader()
                let tempArray = dic["array"] as! [Any]
                
                for checklistDict in tempArray
                {
                    if let tempDict = checklistDict as? [String: Any]
                    {
                        self.feedArray.append(tempDict)
                    }
                }
                self.updatesAnnouncementsTableView.emptyDataSetSource = self
                self.updatesAnnouncementsTableView.emptyDataSetDelegate = self
                self.updatesAnnouncementsTableView.reloadData()
                //                    self.configureReportTypes()
                print(self.feedArray)
                    
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
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.feedArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var cell:PSFeedTableViewCell
        if self.type.rawValue == 0
        {
            cell = tableView.dequeueReusableCell(withIdentifier: "AnnouncementCell", for: indexPath) as! PSFeedTableViewCell
        }
        else
        {
            cell = tableView.dequeueReusableCell(withIdentifier: "SharedReportsCell", for: indexPath) as! PSFeedTableViewCell
        }
        let dic = self.feedArray[indexPath.row] as! NSDictionary
        cell.titleLabel.text = dic["title"] as? String
        
        if self.feedTitle == "Reports"
        {
            cell.dateLabel.text = dic["date"] as? String
        }
        else if self.feedTitle == "Training"
        {
            cell.dateLabel.text = dic["dateTimePosted"] as? String
        }
        else if self.feedTitle == "Policies/Procedures"
        {
            cell.dateLabel.text = dic["dateTimePosted"] as? String
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let dic = self.feedArray[indexPath.row] as! NSDictionary
        PSDataManager.sharedInstance.reportId = dic["reportId"] as! Int
        print(Global.USERTYPE?.rawValue ?? "Global None")
        print(PSDataManager.sharedInstance.loggedInUser?.userType?.rawValue ?? "PSDataManager None")
        print(PSDataManager.sharedInstance.loggedInUser?.userTypeByRole ?? "PSDataManager RoleNone")
        if PSDataManager.sharedInstance.loggedInUser?.userTypeByRole == UserType.UserTypeAdmin.rawValue && feedTitle == "Reports"
        {
            let storyboard = UIStoryboard(name: "User", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "PSReportPostViewController") as! PSReportPostViewController
            vc.reportPostDict = self.feedArray[indexPath.row] as! NSDictionary
            navigationController?.pushViewController(vc,
                                                     animated: true)
        }
        else if PSDataManager.sharedInstance.loggedInUser?.userTypeByRole == UserType.UserTypeNormal.rawValue && feedTitle == "Reports"
        {
            let storyboard = UIStoryboard(name: "User", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "PSReportPostViewController") as! PSReportPostViewController
            vc.reportPostDict = self.feedArray[indexPath.row] as! NSDictionary
            navigationController?.pushViewController(vc,
                                                     animated: true)
        }
        else
        {
            let storyboard = UIStoryboard(name: "User", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "PSFeedDetailViewController") as! PSFeedDetailViewController
//            vc.feedDetailTitle = self.feedTitleLabel.text!
            if dic["title"] is NSNull
            {
                vc.feedDetailTitle = "None"
            }
            else
            {
                vc.feedDetailTitle = (dic["title"] as? String)!
            }
            
            vc.feedDict = dic
            navigationController?.pushViewController(vc,
                                                     animated: true)
        }
        
    }
    
    // MARK: - IBActions
    
    @IBAction func backButtonTouched(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func announcementsViewTouched(_ sender: UITapGestureRecognizer)
    {
//      self.announcementView.backgroundColor=UIColor.init(red: 255/255.0, green: 37/255.0, blue: 1/255.0, alpha: 1.0)
//      self.type = FeedType(rawValue: 0)
        self.updatesAnnouncementsTableView.reloadData()
    }
    
    @IBAction func sharedReportsViewTouched(_ sender: UITapGestureRecognizer)
    {
//      self.sharedreportView.backgroundColor=UIColor.init(red: 255/255.0, green: 37/255.0, blue: 1/255.0, alpha: 1.0)
//      self.type = FeedType(rawValue: 1)
        self.updatesAnnouncementsTableView.reloadData()
    }
    
    @IBAction func filterReportsGestureTouched(sender: UITapGestureRecognizer)
    {
        self.definesPresentationContext = true;
        let termsOfUseVC : PSSortReportsDialogViewController
        let storyBoard = UIStoryboard.init(name: "Admin", bundle: Bundle.main)
        termsOfUseVC = storyBoard.instantiateViewController(withIdentifier: "PSSortReportsDialogViewController") as! PSSortReportsDialogViewController
        termsOfUseVC.view.backgroundColor = UIColor.clear
        termsOfUseVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        termsOfUseVC.delegate = self
        //        self.view.backgroundColor = UIColor.clear
        //        self.modalPresentationStyle = UIModalPresentationStyle.currentContext
        self.present(termsOfUseVC, animated: true)
        {
            
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
    
    //MARK: - PSSortReportsDialogViewControllerDelegate
    
    func applyFilters(filterData: NSMutableDictionary)
    {
        if CEReachabilityManager.isReachable()
        {
            PSUserInterfaceManager.sharedInstance.showLoaderWithText(text: String(format: "%@%@", "Fetching ", self.feedTitle))
            companyId = (PSDataManager.sharedInstance.loggedInUser?.companyId)!
            
            PSAPIManager.sharedInstance.getReportsFor(CompanyId: String(companyId), ReportType: filterData.value(forKey: "ReportType") as! String, ReportedBy: filterData.value(forKey: "ReportedBy") as! String, startdate: filterData.value(forKey: "startdate") as! String, enddate: filterData.value(forKey: "enddate") as! String, success:
            { (dic) in
                
                self.feedArray = [Any]()
                PSUserInterfaceManager.sharedInstance.hideLoader()
                let tempArray = dic["array"] as! [Any]
                
                for checklistDict in tempArray
                {
                    if let tempDict = checklistDict as? [String: Any]
                    {
                        self.feedArray.append(tempDict)
                    }
                }
                self.updatesAnnouncementsTableView.reloadData()
                //                    self.configureReportTypes()
                print(self.feedArray)
                
            }, failure:
            { (error, statusCode) in
                
                PSUserInterfaceManager.sharedInstance.hideLoader()
                if(statusCode==404)
                {
                    PSUserInterfaceManager.showAlert(title: "Fetching", message: ApiResultFailureMessage.InvalidEmailPassword)
                }
                else
                {
                    
                }
                
            }, errorPopup: true)
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
