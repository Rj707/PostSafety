//
//  UpdatesAnnouncementsViewController.swift
//  PostSafety
//
//  Created by Hafiz Saad on 16/05/2018.
//  Copyright © 2018 Now Tel. All rights reserved.
//

enum FeedType :Int
{
    case FeedTypeUnOpened
    case FeedTypeArchived
}

import UIKit



class PSFeedViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,PSSortReportsDialogViewControllerDelegate,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate

{
    @IBOutlet weak var unOpenedLabel: UILabel!
    @IBOutlet weak var archivedLabel: UILabel!
    
    @IBOutlet weak var sharedReportsLabel: UILabel!
    @IBOutlet weak var myReportsLabel: UILabel!
    @IBOutlet weak var allReportsLabel: UILabel!
    
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
    
    var type : FeedType!
    var feedArray = [Any]()
    var archivedArray = [Any]()
    
    var feedTitle: String = ""
    var reportType: String = ""
    var route: String = ""
    var companyId = 0
    var EmployeeID = 0
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.addMenuAction()
        self.updatesAnnouncementsTableView.tableFooterView = UIView.init()
        
        self.type = FeedType.init(rawValue: 0)
        self.updatesAnnouncementsTableView.dataSource = self
        self.updatesAnnouncementsTableView.delegate = self
        
        self.feedTitleLabel.text = self.feedTitle
        
        if  feedTitle == "Reports"
        {
            self.feedTitleLabel.text = "Posts"
        }
        
        
        if PSDataManager.sharedInstance.loggedInUser?.userTypeByRole == UserType.UserTypeAdmin.rawValue && feedTitle == "Reports"
        {
            // User is Admin and Section is Reports/Posts
            self.filterReportsView.isHidden = false
            self.reportsStackView.isHidden = false
            
            self.reportType = "SharedReports"
            self.getSharedReports()
        }
        else
        {
            // Either User is not Admin or Section is not Reports/Posts
            self.filterReportsView.isHidden = true
            self.reportsStackView.isHidden = true
            
            if feedTitle == "Reports"
            {
                self.reportType = "SharedReports"
                self.getSharedReports()
            }
        }
        
        if feedTitle == "Alerts" || feedTitle == "Announcements"
        {
            unOpenedLabel.text = "New & Unopened"
            archivedLabel.text = "Archived"
        }
        else
        {
            unOpenedLabel.text = "Shared Posts"
            archivedLabel.text = "My Posts"
            
            if feedTitle == "Training" || feedTitle == "Policies/Procedures" || feedTitle == "Safety Updates"
            {
                unOpenedLabel.text = "New & Unopened"
                archivedLabel.text = "Archived"
//               self.getInfoFor()
            }
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        if feedTitle == "Training" || feedTitle == "Policies/Procedures" || feedTitle == "Safety Updates"
        {
            self.feedArray = [Any]()
            self.archivedArray = [Any]()
            self.getInfoFor()
        }
        else if feedTitle == "Announcements" || feedTitle == "Alerts"
        {
            
        }
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - APIs
    
    func getAlerts()
    {
        if CEReachabilityManager.isReachable()
        {
            PSUserInterfaceManager.sharedInstance.showLoaderWithText(text: "Fetching Notifications")
            companyId = (PSDataManager.sharedInstance.loggedInUser?.companyId)!
            PSAPIManager.sharedInstance.getNotificationsFor(companyId: String(companyId), success:
                { (dic) in
                    
                    self.archivedArray = [Any] ()
                    PSUserInterfaceManager.sharedInstance.hideLoader()
                    let tempArray = dic["array"] as! [Any]
                    
                    for checklistDict in tempArray
                    {
                        if let tempDict = checklistDict as? [String: Any]
                        {
                            if tempDict["isRead"] as! Int == 0
                            {
                                self.feedArray.append(tempDict)
                            }
                            else
                            {
                                self.archivedArray.append(tempDict)
                                print("Alread Read")
                            }
                        }
                    }
                    
                    if self.type!.rawValue == FeedType.FeedTypeArchived.rawValue
                    {
                        self.feedArray = self.archivedArray
                    }
                    else
                    {
                        self.unOpenedLabel.text = String(format: "%@ (%@)", "New & Unopened",String(self.feedArray.count))
                    }
                    
                    self.updatesAnnouncementsTableView.emptyDataSetSource = self
                    self.updatesAnnouncementsTableView.emptyDataSetDelegate = self
                    self.updatesAnnouncementsTableView.reloadData()
                    
                    
            }, failure:
                { (error:NSError,statusCode:Int) in
                    
                    PSUserInterfaceManager.sharedInstance.hideLoader()
                    if(statusCode==404)
                    {
                        
                        PSUserInterfaceManager.showAlert(title: "Fetching Notifications", message: ApiErrorMessage.ErrorOccured)
                    }
                    else
                    {
                        
                    }
                    
            }, errorPopup: true)
        }
    }
    
    func getInfoFor()
    {
        if CEReachabilityManager.isReachable()
        {
            PSUserInterfaceManager.sharedInstance.showLoaderWithText(text: String(format: "%@%@", "Fetching ", self.feedTitle))
            companyId = (PSDataManager.sharedInstance.loggedInUser?.companyId)!
            PSAPIManager.sharedInstance.getInfoFor(companyId: String(companyId), route: route ,success:
            { (dic) in
                
                self.archivedArray = [Any] ()
                PSUserInterfaceManager.sharedInstance.hideLoader()
                let tempArray = dic["array"] as! [Any]
                
                for checklistDict in tempArray
                {
                    if let tempDict = checklistDict as? [String: Any]
                    {
                        if tempDict["isRead"] as! Int == 0
                        {
                            self.feedArray.append(tempDict)
                        }
                        else
                        {
                            self.archivedArray.append(tempDict)
                            print("Alread Read")
                        }
                    }
                }
                
                if self.type!.rawValue == FeedType.FeedTypeArchived.rawValue
                {
                   self.feedArray = self.archivedArray
                }
                else
                {
                    self.unOpenedLabel.text = String(format: "%@ (%@)", "New & Unopened",String(self.feedArray.count))
                }
                
                self.updatesAnnouncementsTableView.emptyDataSetSource = self
                self.updatesAnnouncementsTableView.emptyDataSetDelegate = self
                self.updatesAnnouncementsTableView.reloadData()
                
                print(self.feedArray)
                
            }, failure:
                { (error:NSError,statusCode:Int) in
                    
                    PSUserInterfaceManager.sharedInstance.hideLoader()
                    if(statusCode==404)
                    {
                        PSUserInterfaceManager.showAlert(title: "Checklist", message: ApiErrorMessage.ErrorOccured)
                    }
                    else
                    {
                        
                    }
                    
            }, errorPopup: true)
        }
    }
    
    func getAllReports()
    {
        if CEReachabilityManager.isReachable()
        {
            var typeOfFetch = self.feedTitle
            if self.feedTitle == "Reports"
            {
                typeOfFetch = "All Posts"
            }
            
            PSUserInterfaceManager.sharedInstance.showLoaderWithText(text: String(format: "%@%@", "Fetching ", typeOfFetch))
            companyId = (PSDataManager.sharedInstance.loggedInUser?.companyId)!
            PSAPIManager.sharedInstance.getAllReportsFor(companyId: String(companyId), success:
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
                        PSUserInterfaceManager.showAlert(title: "Checklist", message: ApiErrorMessage.ErrorOccured)
                    }
                    else
                    {
                        
                    }
                    
            }, errorPopup: true)
        }
    }
    
    func getSharedReports()
    {
        if CEReachabilityManager.isReachable()
        {
            var typeOfFetch = self.reportType
            if self.reportType == "SharedReports"
            {
                typeOfFetch = "Shared Posts"
            }
            else if self.reportType == "MyReports"
            {
                typeOfFetch = "My Posts"
            }
            PSUserInterfaceManager.sharedInstance.showLoaderWithText(text: String(format: "%@%@", "Fetching ", typeOfFetch))
            EmployeeID = (PSDataManager.sharedInstance.loggedInUser?.employeeId)!
            PSAPIManager.sharedInstance.getSharedReportsFor(EmployeeID: String(EmployeeID), Type: reportType ,success:
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
                    
            },
                                                   failure:
                { (error:NSError,statusCode:Int) in
                    
                    PSUserInterfaceManager.sharedInstance.hideLoader()
                    if(statusCode==404)
                    {
                        PSUserInterfaceManager.showAlert(title: "Fetching Posts", message: ApiErrorMessage.ErrorOccured)
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
        
        cell = tableView.dequeueReusableCell(withIdentifier: "AnnouncementCell", for: indexPath) as! PSFeedTableViewCell
        
        let dic = self.feedArray[indexPath.row] as! NSDictionary
        
        if self.feedTitle == "Reports"
        {
            if dic["incidentType"] as? String == "Emergency"
            {
                cell.titleLabel.textColor = UIColor.init(red: 255/255.0, green: 75/255.0, blue: 1/255.0, alpha: 1.0)
            }
            else
            {
                cell.titleLabel.textColor = UIColor.black
            }
            
            cell.titleLabel.text = String(format: "%@ : %@", (dic["incidentType"] as? String)!,(dic["catagory"] as? String)!)
        }
        else
        {
            cell.titleLabel.text = dic["title"] as? String
        }
        
        if self.feedTitle == "Reports"
        {
            cell.dateLabel.text = dic["date"] as? String
            cell.timeLabel.text = dic["time"] as? String
        }
        else if self.feedTitle == "Training"
        {
            cell.dateLabel.text = dic["createdDate"] as? String
            cell.timeLabel.text = dic["createdTime"] as? String
            
        }
        else if self.feedTitle == "Policies/Procedures"
        {
            cell.dateLabel.text = dic["createdDate"] as? String
            cell.timeLabel.text = dic["createdTime"] as? String
        }
        else if self.feedTitle == "Safety Updates"
        {
            cell.dateLabel.text = dic["createdDate"] as? String
            cell.timeLabel.text = dic["createdTime"] as? String
        }
        cell.titleLabel.text =  cell.titleLabel.text?.components(separatedBy: .newlines).joined()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let dic = self.feedArray[indexPath.row] as! NSDictionary
        var cell:PSFeedTableViewCell
        cell = tableView.cellForRow(at: indexPath) as! PSFeedTableViewCell
        
        print(Global.USERTYPE?.rawValue ?? "Global None")
        print(PSDataManager.sharedInstance.loggedInUser?.userType?.rawValue ?? "PSDataManager None")
        print(PSDataManager.sharedInstance.loggedInUser?.userTypeByRole ?? "PSDataManager RoleNone")
        
        if PSDataManager.sharedInstance.loggedInUser?.userTypeByRole == UserType.UserTypeAdmin.rawValue && feedTitle == "Reports"
        {
            PSDataManager.sharedInstance.reportId = dic["reportId"] as! Int
            let storyboard = UIStoryboard(name: "User", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "PSReportPostViewController") as! PSReportPostViewController
            vc.reportPostDict = self.feedArray[indexPath.row] as! NSDictionary
            vc.postTitle =  cell.titleLabel.text!
            if dic["fileName"] is NSNull
            {
                
            }
            else
            {
                navigationController?.pushViewController(vc,
                                                     animated: true)
            }
        }
        else if PSDataManager.sharedInstance.loggedInUser?.userTypeByRole == UserType.UserTypeNormal.rawValue && feedTitle == "Reports"
        {
            PSDataManager.sharedInstance.reportId = dic["reportId"] as! Int
            let storyboard = UIStoryboard(name: "User", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "PSReportPostViewController") as! PSReportPostViewController
            vc.reportPostDict = self.feedArray[indexPath.row] as! NSDictionary
            vc.postTitle =  cell.titleLabel.text!
            navigationController?.pushViewController(vc,
                                                     animated: true)
        }
        else
        {
            // Feed Detail contains Alerts/Announcements/Safety Updates/Trainings/Policies&Procedures
            
            let storyboard = UIStoryboard(name: "User", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "PSFeedDetailViewController") as! PSFeedDetailViewController
            if dic["title"] is NSNull
            {
                vc.feedDetailTitle = "None"
                vc.feedTitle = dic["type"] as! String
            }
            else
            {
                vc.feedTitle = self.feedTitle
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
    
    @IBAction func unOpenedViewTouched(_ sender: UITapGestureRecognizer)
    {
        self.unOpenedView.backgroundColor=UIColor.init(red: 255/255.0, green: 75/255.0, blue: 1/255.0, alpha: 1.0)
        self.archivedView.backgroundColor=UIColor.white
        
        self.unOpenedLabel.textColor = UIColor.white
        self.archivedLabel.textColor = UIColor.black
        
        if unOpenedLabel.text == "Shared Posts"
        {
            self.feedArray = [Any]()
            self.reportType = "SharedReports"
            self.getSharedReports()
        }
        else
        {
            self.feedArray = [Any]()
            self.type = FeedType(rawValue: FeedType.FeedTypeUnOpened.rawValue)
            switch feedTitle
            {
            case "Alerts":
                self.getInfoFor()
                break
                
            case "Announcements":
                self.getInfoFor()
                break
                
            case "Training":
                self.getInfoFor()
                break
                
            case "Policies/Procedures":
                self.getInfoFor()
                break
                
            case "Safety Updates":
                self.getInfoFor()
                break
                
            default:
                print("")
            }
        }
        
    }
    
    @IBAction func archivedViewTouched(_ sender: UITapGestureRecognizer)
    {
        self.archivedView.backgroundColor=UIColor.init(red: 255/255.0, green: 75/255.0, blue: 1/255.0, alpha: 1.0)
        self.unOpenedView.backgroundColor=UIColor.white
        
        self.unOpenedLabel.textColor = UIColor.black
        self.archivedLabel.textColor = UIColor.white
        
        if archivedLabel.text == "My Posts"
        {
            self.feedArray = [Any]()
            self.reportType = "MyReports"
            self.getSharedReports()
        }
        else
        {
            self.feedArray = [Any]()
            self.type = FeedType(rawValue: FeedType.FeedTypeArchived.rawValue)
            switch feedTitle
            {
                case "Alerts":
                    self.getInfoFor()
                    break
                
                case "Announcements":
                    self.getInfoFor()
                    break
                
                case "Training":
                    self.getInfoFor()
                    break
                
                case "Policies/Procedures":
                    self.getInfoFor()
                    break
                
                case "Safety Updates":
                    self.getInfoFor()
                    break
                
                default:
                    print("")
            }
        }
    }
    
    @IBAction func sharedReportsViewTouched(_ sender: UITapGestureRecognizer)
    {
        self.sharedReportsView.backgroundColor=UIColor.init(red: 255/255.0, green: 75/255.0, blue: 1/255.0, alpha: 1.0)
        self.myReportsView.backgroundColor=UIColor.white
        self.allReportsView.backgroundColor=UIColor.white
        
        self.allReportsLabel.textColor = UIColor.black
        self.myReportsLabel.textColor = UIColor.black
        self.sharedReportsLabel.textColor = UIColor.white
        
        self.feedArray = [Any]()
        self.reportType = "SharedReports"
        self.getSharedReports()
    }
    
    @IBAction func myReportsViewTouched(_ sender: UITapGestureRecognizer)
    {
        self.myReportsView.backgroundColor=UIColor.init(red: 255/255.0, green: 75/255.0, blue: 1/255.0, alpha: 1.0)
        self.sharedReportsView.backgroundColor=UIColor.white
        self.allReportsView.backgroundColor=UIColor.white
        
        self.allReportsLabel.textColor = UIColor.black
        self.myReportsLabel.textColor = UIColor.white
        self.sharedReportsLabel.textColor = UIColor.black
        
        self.feedArray = [Any]()
        self.reportType = "MyReports"
        self.getSharedReports()
    }
    
    @IBAction func allReportsViewTouched(_ sender: UITapGestureRecognizer)
    {
        self.allReportsView.backgroundColor=UIColor.init(red: 255/255.0, green: 75/255.0, blue: 1/255.0, alpha: 1.0)
        self.sharedReportsView.backgroundColor=UIColor.white
        self.myReportsView.backgroundColor=UIColor.white
        
        self.allReportsLabel.textColor = UIColor.white
        self.myReportsLabel.textColor = UIColor.black
        self.sharedReportsLabel.textColor = UIColor.black
        
        self.feedArray = [Any]()
        self.getAllReports()
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
            
            PSAPIManager.sharedInstance.getReportsFor(CompanyId: String(companyId), ReportType: filterData.value(forKey: "ReportType") as! String, ReportedBy: filterData.value(forKey: "ReportedBy") as! String, Status: (filterData.value(forKey: "Status") != nil), startdate: filterData.value(forKey: "startdate") as! String, enddate: filterData.value(forKey: "enddate") as! String, success:
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
                
                print(self.feedArray)
                
            }, failure:
            { (error, statusCode) in
                
                PSUserInterfaceManager.sharedInstance.hideLoader()
                if(statusCode==404)
                {
                    PSUserInterfaceManager.showAlert(title: "Fetching", message: ApiErrorMessage.ErrorOccured)
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
        let attributes = [NSFontAttributeName : UIFont.systemFont(ofSize: 19.0),NSForegroundColorAttributeName : UIColor.red ]
        let myAttrString = NSAttributedString(string: myString, attributes: attributes)
        return myAttrString
    }
    
    func getDateString(fromDateTime dateTime:String) -> String
    {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"
        
        if let date = dateFormatterGet.date(from: dateTime)
        {
            print(dateFormatterPrint.string(from: date))
            return dateFormatterPrint.string(from: date)
        }
        else
        {
            print("There was an error decoding the string")
        }
        
        return ""
    }
    
    func getTimeString(fromDateTime dateTime:String) -> String
    {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "h:mm a"
        
        if let date = dateFormatterGet.date(from: dateTime)
        {
            print(dateFormatterPrint.string(from: date))
            return dateFormatterPrint.string(from: date)
        }
        else
        {
            print("There was an error decoding the string")
        }
        
        return ""
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
