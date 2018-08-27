//
//  PSSettingsViewController.swift
//  PostSafety
//
//  Created by Rayyan on 25/06/2018.
//  Copyright © 2018 Now Tel. All rights reserved.
//

import UIKit

class PSSettingsViewController: UIViewController
{
    
    @IBOutlet weak var passwordTextFieldContainer:UIView?
    @IBOutlet weak var confirmPasswordTextFieldContainer:UIView?
    @IBOutlet weak var phoneNumberTextFieldContainer:UIView?
    @IBOutlet weak var passwordTextField:UITextField?
    @IBOutlet weak var confirmPasswordTextField:UITextField?
    @IBOutlet weak var phoneNumberTextField:UITextField?
    
    var EmployeeID = 0
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.configureAndInitialize()
    }
    
    func configureAndInitialize()
    {
        phoneNumberTextField?.text = PSDataManager.sharedInstance.loggedInUser?.phone
        self.passwordTextFieldContainer?.layer.borderWidth = 2
        self.passwordTextFieldContainer?.layer.borderColor = UIColor(red:255/255, green:75/255, blue:1/255, alpha: 1).cgColor
        self.confirmPasswordTextFieldContainer?.layer.borderWidth = 2
        self.confirmPasswordTextFieldContainer?.layer.borderColor = UIColor(red:255/255, green:75/255, blue:1/255, alpha: 1).cgColor
        self.phoneNumberTextFieldContainer?.layer.borderWidth = 2
        self.phoneNumberTextFieldContainer?.layer.borderColor = UIColor(red:255/255, green:75/255, blue:1/255, alpha: 1).cgColor
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
            PSUserInterfaceManager.showAlert(title: "Reset Password", message: FieldsErrorMessage.EmptyPassword)
        }
        else if self.confirmPasswordTextField?.text == ""
        {
            PSUserInterfaceManager.showAlert(title: "Reset Password", message: FieldsErrorMessage.NewPassword)
        }
        else if self.confirmPasswordTextField?.text == PSDataManager.sharedInstance.loggedInUser?.password
        {
            PSUserInterfaceManager.showAlert(title: "Reset Password", message: FieldsErrorMessage.NewOldPasswordMatch)
        }
        else if PSDataManager.sharedInstance.loggedInUser?.password != self.passwordTextField?.text
        {
            let alertController = UIAlertController(title: "Reset Password", message: "The old password is incorrect", preferredStyle: .alert)
            let alertActionCancel = UIAlertAction(title: "OK", style: .cancel)
            { (action) in
                
            }
            alertController.addAction(alertActionCancel)
            self.present(alertController, animated: true, completion: nil)
        }
        else if CEReachabilityManager.isReachable()
        {
            PSUserInterfaceManager.sharedInstance.showLoaderWithText(text: "Reset Password")
            EmployeeID = (PSDataManager.sharedInstance.loggedInUser?.employeeId)!
            PSAPIManager.sharedInstance.UpdateEmployees(employeeID: String(EmployeeID), oldPassword: (self.passwordTextField?.text)!, NewPassword: (self.confirmPasswordTextField?.text)!,
            success:
            {
                (dic) in
                PSUserInterfaceManager.sharedInstance.hideLoader()
                
                let alertController = UIAlertController(title: "Reset Password", message: "You have successfully Updated your password", preferredStyle: .alert)
                let alertActionCancel = UIAlertAction(title: "OK", style: .cancel)
                { (action) in
                        self.navigationController?.popViewController(animated: true)
                }
                alertController.addAction(alertActionCancel)
                self.present(alertController, animated: true, completion: nil)
                
                
            }, failure:
            {
                (error, statusCode) in
                
                PSUserInterfaceManager.sharedInstance.hideLoader()
                if(statusCode==404)
                {
                    PSUserInterfaceManager.showAlert(title: "Reset Password", message: ApiErrorMessage.ErrorOccured)
                }
                else
                {
                    PSUserInterfaceManager.showAlert(title: "Reset Password", message: error.localizedDescription)
                }
                
            }, errorPopup: true)
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
