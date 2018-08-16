//
//  SendVerificationCodeViewController.swift
//  PostSafety
//
//  Created by Hafiz Saad on 16/05/2018.
//  Copyright © 2018 Now Tel. All rights reserved.
//

import UIKit

class PSCreatePasswordViewController: UIViewController
{
    @IBOutlet weak var passwordTextFieldContainer:UIView?
    @IBOutlet weak var confirmPasswordTextFieldContainer:UIView?
    @IBOutlet weak var passwordTextField:UITextField?
    @IBOutlet weak var confirmPasswordTextField:UITextField?
    var loggedInUser : PSUser?
    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.passwordTextFieldContainer?.layer.borderWidth = 2
        self.passwordTextFieldContainer?.layer.borderColor = UIColor(red:255/255, green:75/255, blue:1/255, alpha: 1).cgColor
        self.confirmPasswordTextFieldContainer?.layer.borderWidth = 2
        self.confirmPasswordTextFieldContainer?.layer.borderColor = UIColor(red:255/255, green:75/255, blue:1/255, alpha: 1).cgColor
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
        if self.passwordTextField?.text == ""
        {
            PSUserInterfaceManager.showAlert(title: "Create Password", message: FieldsErrorMessage.EmptyPassword)
        }
        else if self.confirmPasswordTextField?.text == ""
        {
            PSUserInterfaceManager.showAlert(title: "Create Password", message: FieldsErrorMessage.NewPassword)
        }
        else if self.confirmPasswordTextField?.text == PSDataManager.sharedInstance.loggedInUser?.password
        {
            PSUserInterfaceManager.showAlert(title: "Create Password", message: FieldsErrorMessage.NewOldPasswordMatch)
        }
        else if self.loggedInUser?.password != self.passwordTextField?.text
        {
            let alertController = UIAlertController(title: "Create Password", message: "The old password is incorrect", preferredStyle: .alert)
            let alertActionCancel = UIAlertAction(title: "OK", style: .cancel)
            { (action) in
                
            }
            alertController.addAction(alertActionCancel)
            self.present(alertController, animated: true, completion: nil)
        }
        else if CEReachabilityManager.isReachable()
        {
            let EmployeeID = (self.loggedInUser?.employeeId)!
            PSUserInterfaceManager.sharedInstance.showLoaderWithText(text: "Creating Password")
            PSAPIManager.sharedInstance.authenticationManagerAPI.UpdateEmployees(employeeID: String(EmployeeID), oldPassword: (passwordTextField?.text)!, NewPassword: (confirmPasswordTextField?.text)!,
                                                                                 success:
            { (dic) in
                
                PSUserInterfaceManager.sharedInstance.hideLoader()
                var user : PSUser?
                user = PSUser.init()
                user = user?.initWithDictionary(dict: dic as NSDictionary)
                PSDataManager.sharedInstance.loggedInUser = user
                
                self.performSegue(withIdentifier: "NavigateToDashboardFromResetPassword", sender: nil)
                
            },
                                                                                 failure:
            { (error, statusCode) in
                PSUserInterfaceManager.sharedInstance.hideLoader()
                if(statusCode==404)
                {
                    PSUserInterfaceManager.showAlert(title: "Create Password", message: ApiErrorMessage.ErrorOccured)
                }
                else
                {
                    PSUserInterfaceManager.showAlert(title: "Create Password", message: error.localizedDescription)
                }
                
            }, errorPopup: true)
        
        }
        else
        {
            PSUserInterfaceManager.showAlert(title: "Create Password", message: ApiErrorMessage.NoNetwork)
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
