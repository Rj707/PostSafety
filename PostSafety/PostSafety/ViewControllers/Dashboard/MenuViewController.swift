//
//  MenuViewController.swift
//  AppFlow
//
//  Created by Mati ur Rab on 12/7/17.
//  Copyright © 2017 Mati Ur Rab. All rights reserved.
//

import UIKit

@available(iOS 10.0, *)
@available(iOS 10.0, *)
class MenuViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var menuTableView: UITableView!
    
    var menuIdentifiers = [String]()
    var selectedSection = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuIdentifiers.append("userProfileCell")
        menuIdentifiers.append("paymentCell")
        menuIdentifiers.append("helpCell")
        menuIdentifiers.append("logoutCell")
        
        self.menuTableView.separatorStyle = .none
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuIdentifiers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: menuIdentifiers[indexPath.row], for: indexPath) as! MenuTopCell
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: menuIdentifiers[indexPath.row], for: indexPath) as! MenuBottomCell
            if indexPath.row == selectedSection {
                cell.selectedRowBg?.isHidden = false
                cell.selectedRowIndicator?.isHidden = false
            }else{
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
        if indexPath.row==3
        {
            var rootVC : UIViewController?
            rootVC = UIStoryboard(name: "Authentication", bundle: nil).instantiateViewController(withIdentifier: "AuthenticationNavCont")
          
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = rootVC
        }
    }
    
    
}

