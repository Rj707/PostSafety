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
    
    @IBOutlet weak var phoneNumberTextField : UITextField?
    @IBOutlet weak var passowrdTextField : UITextField?

    override func viewDidLoad()
    {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButtonTouched()
    {
        if (self.phoneNumberTextField?.text?.isEmpty)!
        {
            PSUtility.showAlert(title: "Login", message: FieldsErrorMessage.EmptyPhoneNumber)
        }
        else if (self.passowrdTextField?.text?.isEmpty)!
        {
            PSUtility.showAlert(title: "Login", message: FieldsErrorMessage.EmptyPassword)
        }
        else if CEReachabilityManager.isReachable()
        {
            PSAPIManager.sharedInstance.authenticateUserWith(email: (self.phoneNumberTextField?.text)!, password: (self.passowrdTextField?.text)!, success:
            { (dic:Dictionary) in
                let user = PSUser.init()
                Global.USER = user.initWithDictionary(dict: dic as NSDictionary)
                self.performSegue(withIdentifier: "NavigateToDashboard", sender: Any?.self)
                
            }, failure:
                
            {
                    (error:NSError,statusCode:Int) in
                    if(statusCode==404)
                    {
                        PSUtility.showAlert(title: "Login", message: ApiResultFailureMessage.InvalidEmailPassword)
                    }
                    else
                    {
                        
                    }
                    
            }, errorPopup: true)
        }
        else
        {
            PSUtility.showAlert(title: "Login", message: Constants.NO_INTERNET)
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
