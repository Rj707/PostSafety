//
//  SelectLocationViewController.swift
//  PostSafety
//
//  Created by Hafiz Saad on 16/05/2018.
//  Copyright © 2018 Now Tel. All rights reserved.
//

import UIKit

class PSSelectLocationViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate
{
    @IBOutlet weak var locationTableView: UITableView!
    @IBOutlet weak var backgroundView: UIView!
   
    @IBOutlet weak var pageControl : UIPageControl!
    
    var locationsArray = [Any]()
    var companyId = 0
    var locationselected:Bool=false
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.getLocationsforReport()
        self.backgroundView.layer.borderWidth=1
        self.backgroundView.layer.borderColor = UIColor(red:255/255, green:75/255, blue:1/255, alpha: 1).cgColor
        
        if PSDataManager.sharedInstance.report?.reportType == "Hazard" || PSDataManager.sharedInstance.report?.reportType == "Incident"
        {
            pageControl.numberOfPages = 2
            pageControl.currentPage = 1
        }
        else if PSDataManager.sharedInstance.report?.reportType == "NearMiss"
        {
            pageControl.numberOfPages = 3
            pageControl.currentPage = 2
        }

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
                
                PSDataManager.sharedInstance.companyLocationsArray = self.locationsArray
                self.locationTableView.dataSource = self
                self.locationTableView.delegate = self
//                self.configureLocations()
                print(self.locationsArray)
                self.locationTableView.emptyDataSetSource = self as DZNEmptyDataSetSource
                self.locationTableView.emptyDataSetDelegate = self as DZNEmptyDataSetDelegate
                self.locationTableView.reloadData()
                
            }, failure:
                
            {
                (error:NSError,statusCode:Int) in
                PSUserInterfaceManager.sharedInstance.hideLoader()
                if(statusCode==404)
                {
                    PSUserInterfaceManager.showAlert(title: "Locations", message: ApiErrorMessage.ErrorOccured)
                }
                else
                {
                    
                }
                
            }, errorPopup: true)
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
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.locationsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var cell:PSCategoryTableViewCell
        cell = tableView.dequeueReusableCell(withIdentifier: "PSCategoryTableViewCell") as! PSCategoryTableViewCell
        let dic = self.locationsArray[indexPath.row] as! NSDictionary
        cell.categoryTitleLabel.text = dic["branchName"] as? String ?? "No Address"
        cell.data = self.locationsArray[indexPath.row] as! NSDictionary
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        var cell:PSCategoryTableViewCell
        cell = tableView.cellForRow(at: indexPath) as! PSCategoryTableViewCell
        PSDataManager.sharedInstance.report?.reportLocation = cell.data["branchName"] as? String ?? "No Address"
        self.performSegue(withIdentifier: "toReportSummaryFromLocation", sender: cell.data["branchId"])
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let summaryVC = segue.destination as! PSReportSummaryViewController
        summaryVC.locationID = sender as! Int
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
 

}
