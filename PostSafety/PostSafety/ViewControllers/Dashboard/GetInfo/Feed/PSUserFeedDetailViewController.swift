//
//  AnnouncementDetailViewController.swift
//  PostSafety
//
//  Created by Hafiz Saad on 16/05/2018.
//  Copyright © 2018 Now Tel. All rights reserved.
//

import UIKit

class PSUserFeedDetailViewController: UIViewController
{
    @IBOutlet weak var menuButton:UIButton!
    @IBOutlet weak var feedDetailTitleLabel: UILabel!
    @IBOutlet weak var feedDetailTextView: UITextView?
    @IBOutlet weak var feedDetailAttachmentButton: UIButton!
    
    var feedDetailTitle: String = ""
    var feedTitle: String = ""
    var feedDict = NSDictionary.init()
    var attachmentString : String = ""
    var baseURLForAttachment : String = ""
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.addMenuAction()
        
        self.feedDetailTextView?.layer.borderWidth=1
        self.feedDetailTextView?.layer.borderColor = UIColor(red:255/255, green:75/255, blue:1/255, alpha: 1).cgColor
        
        self.feedDetailTitleLabel.text = self.feedDict["title"] as? String
        self.feedDetailTextView?.text = self.feedDict["details"] is NSNull ? "No Data" : self.feedDict["details"] as! String
        self.feedDetailTextView?.isEditable = false
        if feedDict["isRead"] as! Int == 1
        {
            print("Read:No need to call API")
        }
        else
        {
            switch feedTitle
            {
                case "Alerts":
                
                    let ID = feedDict["notificationId"] as! NSNumber
                    let route = Route.NotificationIsRead.rawValue
                    self.archiveGetInfosFor(ID: ID.stringValue, route: route)
                    
                break
                
                case "Announcements":
                    let ID = feedDict["notificationId"] as! NSNumber
                    let route = Route.NotificationIsRead.rawValue
                    self.archiveGetInfosFor(ID: ID.stringValue, route: route)
                
                break
                
                case "Training":
                    let ID = feedDict["traningId"] as! NSNumber
                    let route = Route.TrainingIsRead.rawValue
                    self.archiveGetInfosFor(ID: ID.stringValue , route: route)
                
                break
                
                case "Policies/Procedures":
                    let ID = feedDict["id"] as! NSNumber

                    let route = Route.ProcedurePolicyRead.rawValue
                    self.archiveGetInfosFor(ID: ID.stringValue, route: route)
                
                break
                
                case "Safety Updates":
                    let ID = feedDict["safetyId"] as! NSNumber
                    let route = Route.SafetyUpdatesRead.rawValue
                    self.archiveGetInfosFor(ID: ID.stringValue, route: route)
                
                break
                
                default:
                    print("")
            }
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
                baseURLForAttachment = (self.feedDict["url"] as? String)!
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
            baseURLForAttachment = (self.feedDict["url"] as? String)!
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
        let VC = storyboard?.instantiateViewController(withIdentifier: "PSFeedAttachmentViewController") as? PSFeedAttachmentViewController
        let transition = CATransition()
        transition.duration = 0.1
        transition.type = kCATransitionFade
        transition.subtype = kCATransitionFromBottom
        VC?.attachmentString = attachmentString
        VC?.baseURLForAttachment = baseURLForAttachment
        navigationController?.view.layer.add(transition, forKey: kCATransition)
        if let aVC = VC
        {
            navigationController?.pushViewController(aVC, animated: false)
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
    
    func archiveGetInfosFor(ID:String, route:String)
    {
        if CEReachabilityManager.isReachable()
        {
//            PSUserInterfaceManager.sharedInstance.showLoaderWithText(text: String(format: "%@%@", "Archiving ", self.feedTitle))
            let EmployeeId = (PSDataManager.sharedInstance.loggedInUser?.employeeId)!
            PSAPIManager.sharedInstance.archiveGetInfoFor(EmployeeId : String(EmployeeId), ID: ID, route:route  ,success:
            { (dic) in
                
                    
            }, failure:
                { (error:NSError,statusCode:Int) in
                    
//                    PSUserInterfaceManager.sharedInstance.hideLoader()
                    if(statusCode==404)
                    {
                        PSUserInterfaceManager.showAlert(title: "Archiving", message: ApiErrorMessage.ErrorOccured)
                    }
                    else
                    {
                        PSUserInterfaceManager.showAlert(title: "Archiving", message: error.localizedDescription)
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
