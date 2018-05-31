//
//  PersonalInformationViewController.swift
//  PostSafety
//
//  Created by Hafiz Saad on 16/05/2018.
//  Copyright © 2018 Now Tel. All rights reserved.
//

import UIKit

class PSPersonalInformationViewController: UIViewController
{

    @IBOutlet weak var emailTextField : UITextField?
    @IBOutlet weak var phoneNumberTextField : UITextField?
    @IBOutlet weak var currentPasswordTextField : UITextField?
    @IBOutlet weak var newPassowrdTextField : UITextField?
    override func viewDidLoad()
    {
        super.viewDidLoad()
        emailTextField?.text = PSDataManager.sharedInstance.loggedInUser?.emailId
        phoneNumberTextField?.text = PSDataManager.sharedInstance.loggedInUser?.phone
        currentPasswordTextField?.text = PSDataManager.sharedInstance.loggedInUser?.password
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
    
    @IBAction func saveChangesButtonTouched(_ sender: UIButton)
    {
        PSAPIManager.sharedInstance.authenticationManagerAPI.UpdateEmployees(employeeID: (Global.USER?.employeeId.description)!, oldPassword: (currentPasswordTextField?.text)!, NewPassword: (newPassowrdTextField?.text)!,success:
            { (dic) in
                var user : PSUser?
                user = PSUser.init()
                user = user?.initWithDictionary(dict: dic as NSDictionary)
                PSDataManager.sharedInstance.loggedInUser = user
            },
                                                        failure:
            { (error, statusCode) in
                
            }, errorPopup: true)
        
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
