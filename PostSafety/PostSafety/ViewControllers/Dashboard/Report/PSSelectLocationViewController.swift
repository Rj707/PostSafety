//
//  SelectLocationViewController.swift
//  PostSafety
//
//  Created by Hafiz Saad on 16/05/2018.
//  Copyright © 2018 Now Tel. All rights reserved.
//

import UIKit

class PSSelectLocationViewController: UIViewController,UITableViewDelegate,UITableViewDataSource
{
    @IBOutlet weak var locationTableView: UITableView!
    @IBOutlet weak var backgroundView: UIView!
   
    
    var locationsArray = [Any]()
    var companyId = 0
    var locationselected:Bool=false
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        self.getLocationsforReport()
        self.backgroundView.layer.borderWidth=1
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
                self.locationTableView.dataSource = self
                self.locationTableView.delegate = self
//                self.configureLocations()
                print(self.locationsArray)
                self.locationTableView.reloadData()
                
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
        cell.categoryTitleLabel.text = dic["branchAddress"] as? String
        cell.data = self.locationsArray[indexPath.row] as! NSDictionary
        //        cell.contentView.layer.borderWidth=1
        //        cell.contentView.layer.borderColor = UIColor(red:255/255, green:75/255, blue:1/255, alpha: 1).cgColor
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        var cell:PSCategoryTableViewCell
        cell = tableView.cellForRow(at: indexPath) as! PSCategoryTableViewCell
        Global.REPORT?.reportLocation = cell.data["branchAddress"] as? String
        self.performSegue(withIdentifier: "toReportSummaryFromLocation", sender: cell.data["branchId"])
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let summaryVC = segue.destination as! PSReportSummaryViewController
        summaryVC.locationID = sender as! Int
    }
 

}
