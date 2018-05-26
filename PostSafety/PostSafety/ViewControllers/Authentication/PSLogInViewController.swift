//
//  LogInViewController.swift
//  PostSafety
//
//  Created by Hafiz Saad on 16/05/2018.
//  Copyright © 2018 Now Tel. All rights reserved.
//

import UIKit

class PSLogInViewController: UIViewController
{

    override func viewDidLoad()
    {
        super.viewDidLoad()
        PSAPIManager.sharedInstance.authenticateUserWith(email: "4038709552", password: "123454", success:
            { (dic:Dictionary) in
            
            }, failure:
            { (error:NSError) in
            
            }, errorPopup: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
