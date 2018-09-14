//
//  DashboardViewController.swift
//  PostSafety
//
//  Created by Hafiz Saad on 16/05/2018.
//  Copyright © 2018 Now Tel. All rights reserved.
//

import UIKit

class PSDashboardViewController: UIViewController
{
    
    @IBOutlet weak var menuButton:UIButton!
    @IBOutlet weak var receiveContainer:UIView!
    @IBOutlet weak var reportContainer:UIView!
    
    var locationsArray = [Any]()
    var offlinePost : PSPost?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if PSDataManager.sharedInstance.isPushNotificationNavigation != 7
        {
            self.performSegue(withIdentifier: "toGetInfo", sender: self)
        }
        else
        {
           self.getLocationsforReport()
        }
        
//        print(PSDataManager.sharedInstance.offlinePostsArray)
        
        self.addMenuAction()
        
//        self.submitOfflinePosts()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        self.submitOfflinePosts()
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        if PSDataManager.sharedInstance.isPushNotificationNavigation == 1
        {
            
        }
        else
        {
            
        }
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configureAndInitialize()
    {
        
    }
    
    // MARK: - IBActions
    
    @IBAction func backButtonTouched(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    func addMenuAction()
    {
        if self.revealViewController() != nil
        {
            menuButton.addTarget(self.revealViewController(), action: #selector(self.revealViewController().rightRevealToggle(_:)), for: .touchUpInside)
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
            let menuVC = revealViewController().rightViewController as? MenuViewController
            
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
    
    // MARK: - APIs
    
    func getLocationsforReport() -> Void
    {
        if CEReachabilityManager.isReachable()
        {
            let companyId = (PSDataManager.sharedInstance.loggedInUser?.companyId)!
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
                self.saveCompanyLocations()
                PSDataManager.sharedInstance.companyLocationsArray = self.locationsArray
                    
            }, failure:
                
            {
                (error:NSError,statusCode:Int) in
                    
            }, errorPopup: true)
        }
        else
        {
            self.loadCompanyLocations()
        }

    }
    
//    func saveCompanyLocations()
//    {
//        let companyLocationsData = NSKeyedArchiver.archivedData(withRootObject: self.locationsArray)
//        UserDefaults.standard.set(companyLocationsData, forKey: "CompanyLocations")
//
//    }
    
//    func loadCompanyLocations()
//    {
//        let companyLocationsData = UserDefaults.standard.value(forKey: "CompanyLocations") as? Data
//        
//        if let companyLocationsData = companyLocationsData
//        {
//            let companyLocationsArray = NSKeyedUnarchiver.unarchiveObject(with: companyLocationsData as Data) as! [Any]
//            
//            if companyLocationsArray != nil
//            {
//                // do something…
//                self.locationsArray = companyLocationsArray as [Any]
//                PSDataManager.sharedInstance.companyLocationsArray = self.locationsArray
//                print(self.locationsArray)
//                print("locationsArray")
//            }
//            
//        }
//
//    }
    
    func saveCompanyLocations()
    {
        let companyLocationsData = NSKeyedArchiver.archivedData(withRootObject: self.locationsArray)
        UserDefaults.standard.set(companyLocationsData, forKey: "CompanyLocations")
        
    }
    
    func loadCompanyLocations()
    {
        let companyLocationsData = UserDefaults.standard.value(forKey: "CompanyLocations") as? Data
        
        if let companyLocationsData = companyLocationsData
        {
            let companyLocationsArray = NSKeyedUnarchiver.unarchiveObject(with: companyLocationsData as Data) as! [Any]
            
            if companyLocationsArray != nil
            {
                // do something…
                self.locationsArray = companyLocationsArray as [Any]
                PSDataManager.sharedInstance.companyLocationsArray = self.locationsArray
                
            }
            
        }
    }
    
    func submitOfflinePosts()
    {
        if CEReachabilityManager.isReachable()
        {
            if PSDataManager.sharedInstance.isOfflinePostsExist()
            {
                print(PSDataManager.sharedInstance.offlinePostsArray)
                offlinePost = PSPost.init()
                offlinePost  = PSDataManager.sharedInstance.offlinePostsArray[0]
                
                let EmployeeId = offlinePost?.employeeID
                let incidentTypeID = offlinePost?.incidentTypeID
                
                var locationId = 0
                var categoryID = 0
                var details = ""
                var subCategoryID = 0
                var isReportPSI = NSNumber.init(booleanLiteral: false)
                if incidentTypeID == 4
                {
                    subCategoryID = (offlinePost?.subCategoryID)!
                    if offlinePost?.isReportPSI == 0
                    {
                        isReportPSI = NSNumber.init(booleanLiteral: false)
                    }
                    else
                    {
                        isReportPSI = NSNumber.init(booleanLiteral: true)
                    }
                }
                if incidentTypeID != 1
                {
                    locationId = (offlinePost?.locationId)!
                    categoryID = (offlinePost?.categoryID)!
                    details = (offlinePost?.details)!
                }
                let type = offlinePost?.type
                let fileData = offlinePost?.fileData
                
                
                DispatchQueue.global(qos: .background).async
                    {
                        PSAPIManager.sharedInstance.submitPostOfflineFor(EmployeeId: EmployeeId!, IncidentTypeID: incidentTypeID!, LocationId: locationId, Details: details, CatagoryId: categoryID, SubCatagory: subCategoryID, IsPSI: isReportPSI as! Bool, FileType: type!, data: fileData!, success:
                            { (dic) in
                                
                                PSDataManager.sharedInstance.removeSubmittedPost()
                                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0, execute:
                                    {
                                        self.submitOfflinePosts()
                                })
                                
                        }, failure:
                            { (error, statusCode) in
                                
                                
                        }, progress:
                            {
                                (prog:Double) in
                                
                        }, errorPopup: true)
                        
                        
                        print("This is run on the background queue")
                }
            }
            else
            {
                
            }
        }
    }

}
