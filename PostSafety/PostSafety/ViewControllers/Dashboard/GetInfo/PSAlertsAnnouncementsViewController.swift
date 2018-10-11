//
//  PSAlertsAnnouncementsViewController.swift
//  PostSafety
//
//  Created by Rayyan on 24/06/2018.
//  Copyright © 2018 Now Tel. All rights reserved.
//

import UIKit
import Crashlytics
class PSAlertsAnnouncementsViewController: UIViewController
{
    
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var menuButton:UIButton!
    
    var alertsArray = [Any]()
    var companyId = 0
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.configureAndInitialize()
        
        self.addMenuAction()
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        if PSDataManager.sharedInstance.isPushNotificationNavigation != 7
        {
            switch PSDataManager.sharedInstance.notificatinType?.rawValue
            {
                case PushNotificatinType.PushNotificatinTypeAlert.rawValue:
                    self.alertsGestureTapped((Any).self)
                    break
                case PushNotificatinType.PushNotificatinTypeAnnouncement.rawValue:
                    self.announcementsGestureTapped((Any).self)
                    break
                case PushNotificatinType.PushNotificatinTypeSafety.rawValue:
                    self.safetyUpdatesGestureTapped((Any).self)
                    break
                default:
                    break
            }
            
        }
        else
        {
            
        }
    }
    
    func configureAndInitialize()
    {
        self.view1.layer.borderWidth=1
        self.view2.layer.borderWidth=1
        self.view3.layer.borderWidth=1
        self.view1.layer.borderColor = UIColor(red:255/255, green:75/255, blue:1/255, alpha: 1).cgColor
        self.view2.layer.borderColor = UIColor(red:255/255, green:75/255, blue:1/255, alpha: 1).cgColor
        self.view3.layer.borderColor = UIColor(red:255/255, green:75/255, blue:1/255, alpha: 1).cgColor
    }
    
    // MARK: - IBActions
    
    @IBAction func backButtonTouched(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func alertsGestureTapped(_ sender: Any)
    {
        let storyboard = UIStoryboard(name: "User", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PSUserFeedViewController") as! PSUserFeedViewController
        vc.feedTitle = "Alerts"
        let resultPredicate = NSPredicate(format: "type = %@", "Alert")
        vc.feedArray = (self.alertsArray as NSArray).filtered(using: resultPredicate)
        navigationController?.pushViewController(vc,
                                                 animated: true)
    }
    
    @IBAction func announcementsGestureTapped(_ sender: Any)
    {
        let storyboard = UIStoryboard(name: "User", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PSUserFeedViewController") as! PSUserFeedViewController
        vc.feedTitle = "Announcements"
        let resultPredicate = NSPredicate(format: "type = %@", "Announcement")
        vc.feedArray = (self.alertsArray as NSArray).filtered(using: resultPredicate)
        navigationController?.pushViewController(vc,
                                                 animated: true)
    }
    
    @IBAction func safetyUpdatesGestureTapped(_ sender: Any)
    {
//        let storyboard = UIStoryboard(name: "User", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "PSUserFeedViewController") as! PSUserFeedViewController
//        vc.feedTitle = "Safety Updates"
//        navigationController?.pushViewController(vc,
//                                                 animated: true)
        
        
        let storyboard = UIStoryboard(name: "User", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PSUserFeedViewController") as! PSUserFeedViewController
        vc.feedTitle = "Safety Updates"
        vc.route = Route.SafetyUpdates.rawValue
        navigationController?.pushViewController(vc,
                                                 animated: true)
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
