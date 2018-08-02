//
//  MenuViewController.swift
//  AppFlow
//
//  Created by Mati ur Rab on 12/7/17.
//  Copyright © 2017 Mati Ur Rab. All rights reserved.
//

import UIKit
import RealmSwift

@available(iOS 10.0, *)
@available(iOS 10.0, *)
class MenuViewController: UIViewController,UITableViewDelegate, UITableViewDataSource
{

    @IBOutlet weak var menuTableView: UITableView!
    
    var dashboardNavViewController: UINavigationController?
    
    var realm: Realm!
    
    var menuIdentifiers = [String]()
    var selectedSection = 1
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        if(!(realm != nil))
        {
            realm = try! Realm()
        }
        menuIdentifiers.append("userProfileCell")
        menuIdentifiers.append("paymentCell")
        menuIdentifiers.append("helpCell")
        menuIdentifiers.append("logoutCell")
        
        self.menuTableView.separatorStyle = .none
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return menuIdentifiers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if indexPath.row == 0
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: menuIdentifiers[indexPath.row], for: indexPath) as! MenuTopCell
            return cell
        }
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: menuIdentifiers[indexPath.row], for: indexPath) as! MenuBottomCell
            if indexPath.row == selectedSection
            {
                cell.selectedRowBg?.isHidden = false
                cell.selectedRowIndicator?.isHidden = false
            }
            else
            {
                cell.selectedRowBg?.isHidden = true
                cell.selectedRowIndicator?.isHidden = true
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        selectedSection = indexPath.row
        tableView.reloadData()
        if indexPath.row==0
        {
            let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "PSSettingsViewController") as! PSSettingsViewController
            
            // homeNavViewController is basically the Nav Controller of the rear VC of revealViewController, which is Dashboadr VC
            dashboardNavViewController?.pushViewController(vc, animated: false)
            revealViewController().revealToggle(animated: true)
            
        }
        if indexPath.row==1
        {
            let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "FrontNavCont") as! UINavigationController
            
            // homeNavViewController is basically the Nav Controller of the rear VC of revealViewController, which is Dashboadr VC
            revealViewController().frontViewController = vc
            revealViewController().revealToggle(animated: true)
            
        }
        
        if indexPath.row==3
        {
            if PSDataManager.sharedInstance.isUserLoggedIn()
            {
                try! realm.write
                {
                    realm.delete(Global.DATA_MANAGER.loggedInUser!)
                }
            }
            
            var rootVC : UIViewController?
            rootVC = UIStoryboard(name: "Authentication", bundle: nil).instantiateViewController(withIdentifier: "PSLogInNavigationController")
          
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = rootVC
        }
    }
    
    
}

