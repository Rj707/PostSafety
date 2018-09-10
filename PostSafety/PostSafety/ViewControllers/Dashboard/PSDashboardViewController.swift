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
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if PSDataManager.sharedInstance.isPushNotificationNavigation != 5
        {
            self.performSegue(withIdentifier: "toGetInfo", sender: self)
        }
        else
        {
           self.getLocationsforReport()
        }
        
        self.addMenuAction()
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
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
                PSDataManager.sharedInstance.companyLocationsArray = self.locationsArray
                    
            }, failure:
                
                {
                    (error:NSError,statusCode:Int) in
//                    PSUserInterfaceManager.sharedInstance.hideLoader()
//                    if(statusCode==404)
//                    {
//                        PSUserInterfaceManager.showAlert(title: "Locations", message: ApiErrorMessage.ErrorOccured)
//                    }
//                    else
//                    {
//                        PSUserInterfaceManager.showAlert(title: "Locations", message: error.localizedDescription)
//                    }
                    
            }, errorPopup: true)
        }
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

}
