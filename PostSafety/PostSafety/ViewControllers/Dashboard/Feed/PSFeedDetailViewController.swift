//
//  AnnouncementDetailViewController.swift
//  PostSafety
//
//  Created by Hafiz Saad on 16/05/2018.
//  Copyright © 2018 Now Tel. All rights reserved.
//

import UIKit

class PSFeedDetailViewController: UIViewController
{
    @IBOutlet weak var menuButton:UIButton!
    @IBOutlet weak var feedDetailTitleLabel: UILabel!
    @IBOutlet weak var feedDetailTextView: UITextView!
    @IBOutlet weak var feedDetailAttachmentButton: UIButton!
    
    var feedDetailTitle: String = ""
    var feedTitle: String = ""
    var feedDict = NSDictionary.init()
    var attachmentString : String = ""
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.addMenuAction()
        
        self.feedDetailTitleLabel.text = self.feedDict["title"] as? String
        self.feedDetailTextView.text = self.feedDict["details"] is NSNull ? "No Data" : self.feedDict["details"] as! String
        
        switch feedTitle
        {
            case "Alerts":
            
                let ID = feedDict["notificationId"]
                let route = Route.NotificationIsRead.rawValue
                self.archiveGetInfosFor(ID: ID as! String, route: route)
                
            break
            
            case "Announcements":
                let ID = feedDict["notificationId"]
                let route = Route.NotificationIsRead.rawValue
                self.archiveGetInfosFor(ID: ID as! String, route: route)
            
            break
            
            case "Training":
                let ID = feedDict["traningId"]
                let route = Route.TrainingIsRead.rawValue
                self.archiveGetInfosFor(ID: ID as! String, route: route)
            
            break
            
            case "Policies/Procedures":
                let ID = feedDict["id"]

                let route = Route.ProcedurePolicyRead.rawValue
                self.archiveGetInfosFor(ID: ID as! String, route: route)
            
            break
            
            case "Safety Updates":
                let ID = feedDict["safetyId"]
                let route = Route.SafetyUpdatesRead.rawValue
                self.archiveGetInfosFor(ID: ID as! String, route: route)
            
            break
            
            default:
                print("")
        }
        
        
        if feedTitle == "Alerts" || feedTitle == "Announcements"
        {
            if self.feedDict["pictureUrl"] is NSNull
            {
                self.feedDetailAttachmentButton.isHidden = true
            }
            else
            {
                self.feedDetailAttachmentButton.isHidden = false
                self.feedDetailAttachmentButton.setTitle(self.feedDict["pictureUrl"] as? String, for: UIControlState.normal)
                attachmentString = (self.feedDict["pictureUrl"] as? String)!
            }
        }
        else if self.feedDict["pictureUrl"] is NSNull
        {
            self.feedDetailAttachmentButton.isHidden = true
        }
        else
        {
            self.feedDetailAttachmentButton.isHidden = false
            self.feedDetailAttachmentButton.setTitle(self.feedDict["fileName"] as? String, for: UIControlState.normal)
            attachmentString = (self.feedDict["fileName"] as? String)!
        }
        
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
    
    @IBAction func attachmentButtonTouched(_ sender: UIButton)
    {
        let storyboard = UIStoryboard(name: "User", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PSAttachmentViewController") as! PSAttachmentViewController
        vc.attachmentString = attachmentString
        vc.modalPresentationStyle = .popover
        vc.modalTransitionStyle = .coverVertical
        self.present(vc, animated: true, completion: nil)
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
    
    func archiveGetInfosFor(ID:String, route:String)
    {
        if CEReachabilityManager.isReachable()
        {
//            PSUserInterfaceManager.sharedInstance.showLoaderWithText(text: String(format: "%@%@", "Archiving ", self.feedTitle))
            let companyId = (PSDataManager.sharedInstance.loggedInUser?.companyId)!
            PSAPIManager.sharedInstance.archiveGetInfoFor(companyId: String(companyId), ID: ID, route:route  ,success:
            { (dic) in
                
//                PSUserInterfaceManager.sharedInstance.hideLoader()
                
//                let tempArray = dic["array"] as! [Any]
//
//                for checklistDict in tempArray
//                {
//                    if let tempDict = checklistDict as? [String: Any]
//                    {
//                        if tempDict["isRead"] as! Int == 0
//                        {
//                            self.feedArray.append(tempDict)
//                        }
//                        else
//                        {
//                            print("Alread Read")
//                        }
//                    }
//                }
                
                    
            }, failure:
                { (error:NSError,statusCode:Int) in
                    
//                    PSUserInterfaceManager.sharedInstance.hideLoader()
                    if(statusCode==404)
                    {
                        PSUserInterfaceManager.showAlert(title: "Archiving", message: ApiResultFailureMessage.InvalidEmailPassword)
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
