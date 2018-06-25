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
    
    @IBOutlet weak var nameTextField : UITextField?
    @IBOutlet weak var phoneNumberTextField : UITextField?
    @IBOutlet weak var passowrdTextField : UITextField?
    @IBOutlet weak var termsLabel : UILabel?

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.phoneNumberTextField?.text = "4038709552"
        self.passowrdTextField?.text = "123456"
        
        var text: NSMutableAttributedString? = nil
        if let aText = termsLabel?.attributedText
        {
            text = NSMutableAttributedString(attributedString: aText)
        }
        text?.addAttribute(NSForegroundColorAttributeName, value: UIColor(red:255/255, green:75/255, blue:1/255, alpha: 1), range: NSRange(location: 39, length: 12))
        termsLabel?.attributedText = text
        
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
            PSUserInterfaceManager.showAlert(title: "Login", message: FieldsErrorMessage.EmptyPhoneNumber)
        }
        else if (self.passowrdTextField?.text?.isEmpty)!
        {
            PSUserInterfaceManager.showAlert(title: "Login", message: FieldsErrorMessage.EmptyPassword)
        }
        else if CEReachabilityManager.isReachable()
        {
            PSAPIManager.sharedInstance.authenticateUserWith(email: (self.phoneNumberTextField?.text)!, password: (self.passowrdTextField?.text)!, success:
            { (dic) in
                var user : PSUser?
                user = PSUser.init()
                user = user?.initWithDictionary(dict: dic as NSDictionary)
                PSDataManager.sharedInstance.loggedInUser = user
                self.performSegue(withIdentifier: "NavigateToDashboard", sender: Any?.self)
                
            } , failure:
                
            {
                    (error:NSError,statusCode:Int) in
                    if(statusCode==404)
                    {
                        PSUserInterfaceManager.showAlert(title: "Login", message: ApiResultFailureMessage.InvalidEmailPassword)
                    }
                    else
                    {
                        
                    }
                    
            }, errorPopup: true)
        }
        else
        {
            PSUserInterfaceManager.showAlert(title: "Login", message: ApiErrorMessage.NoNetwork)
        }
        
    }
    
    @IBAction func termsOfUseButtonTouched(sender: UITapGestureRecognizer)
    {
        self.definesPresentationContext = true;
        let termsOfUseVC : PSTermsOfUseViewController
        termsOfUseVC = self.storyboard?.instantiateViewController(withIdentifier: "PSTermsOfUseViewController") as! PSTermsOfUseViewController
        termsOfUseVC.view.backgroundColor = UIColor.clear
        termsOfUseVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
//        self.view.backgroundColor = UIColor.clear
//        self.modalPresentationStyle = UIModalPresentationStyle.currentContext
        self.present(termsOfUseVC, animated: true)
        {
            
        }
        
//        self.definesPresentationContext = true; //self is presenting view controller
//        presentedController.view.backgroundColor = [YOUR_COLOR with alpha OR clearColor]
//        presentedController.modalPresentationStyle = UIModalPresentationOverCurrentContext;
//
//        [self presentViewController:presentedController animated:YES completion:nil];
    }
    
    @IBAction func userTypeSegmentValueChanged(sender: UISegmentedControl)
    {
        print(sender.selectedSegmentIndex)
        Global.USERTYPE? = UserType(rawValue: sender.selectedSegmentIndex)!
        print(Global.USERTYPE ?? "UserType")
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
