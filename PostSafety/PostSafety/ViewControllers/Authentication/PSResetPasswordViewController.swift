//
//  PSResetPasswordViewController.swift
//  PostSafety
//
//  Created by Rayyan on 14/10/2018.
//  Copyright © 2018 Now Tel. All rights reserved.
//

import UIKit

class PSResetPasswordViewController: UIViewController
{

    @IBOutlet weak var phoneNumberTextFieldContainer:UIView?
    @IBOutlet weak var phoneNumberTextField:UITextField?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.phoneNumberTextFieldContainer?.layer.borderWidth = 2
        self.phoneNumberTextFieldContainer?.layer.borderColor = UIColor(red:255/255, green:75/255, blue:1/255, alpha: 1).cgColor
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func crossButtonTouched(_ sender: UIButton)
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sendPasswordButtonTouched(_ sender: UIButton)
    {
        if self.phoneNumberTextField?.text == ""
        {
            PSUserInterfaceManager.showAlert(title: "Reset Password", message: FieldsErrorMessage.EmptyPhoneNumber)
        }
        else if CEReachabilityManager.isReachable()
        {
            PSUserInterfaceManager.sharedInstance.showLoaderWithText(text: "Resetting Password")
            PSAPIManager.sharedInstance.ResetPasswordFor(Number: self.phoneNumberTextField?.text ?? "",
                                                        success:
            { (dic) in
                    
                PSUserInterfaceManager.sharedInstance.hideLoader()
                if dic["SUCCESS"] as! String == "Reset Password Sent"
                {
                    self.dismiss(animated: true, completion: nil)
                }
                else
                {
                    PSUserInterfaceManager.showAlert(title: "Reset Password", message: "Something went wrong, unable to send the password")
                }
                    
            },
                                                        failure:
                { (error, statusCode) in
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
            PSUserInterfaceManager.showAlert(title: "Reset Password", message: ApiErrorMessage.NoNetwork)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
