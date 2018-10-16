//
//  LogInViewController.swift
//  PostSafety
//
//  Created by Hafiz Saad on 16/05/2018.
//  Copyright © 2018 Now Tel. All rights reserved.
//

import UIKit
import FirebaseInstanceID

class PSLogInViewController: UIViewController
{
    
    @IBOutlet weak var nameTextField : UITextField?
    @IBOutlet weak var phoneNumberTextField : UITextField?
    @IBOutlet weak var passowrdTextField : UITextField?
    @IBOutlet weak var termsLabel : UILabel?
    @IBOutlet weak var rememberMeSwitch : UISwitch?
    
    var loggedInUser : PSUser?
    var locationsArray = [Any]()
    
    var cheklistArray = [Any]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.configureAndInitialize()
    }
    
    func configureAndInitialize()
    {
//        self.phoneNumberTextField?.text = "4034790605"
////        4034790605
////        4038709552
////        2222222222
//        self.passowrdTextField?.text = "123456"
        
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
    
    // MARK: - IBAction
    
    @IBAction func loginButtonTouched()
    {
        self.loginUser()
    }
    
    @IBAction func termsOfUseButtonTouched(sender: UITapGestureRecognizer)
    {
        self.definesPresentationContext = true;
        let termsOfUseVC : PSTermsOfUseViewController
        termsOfUseVC = self.storyboard?.instantiateViewController(withIdentifier: "PSTermsOfUseViewController") as! PSTermsOfUseViewController
        termsOfUseVC.view.backgroundColor = UIColor.clear
        termsOfUseVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext

        self.present(termsOfUseVC, animated: true)
        {
            
        }
    }
    
    // MARK: - APIs
    
    func loginUser() -> Void
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
            PSUserInterfaceManager.sharedInstance.showLoaderWithText(text: "Logging In")
            PSAPIManager.sharedInstance.authenticateUserWith(email: (self.phoneNumberTextField?.text)!, password: (self.passowrdTextField?.text)!, success:
                { (dic) in
                    
                    self.getDeviceToken()
                    var user : PSUser?
                    user = PSUser.init()
                    
                    user = user?.initWithDictionary(dict: dic as NSDictionary)
                    self.loggedInUser = user
                    if (self.rememberMeSwitch?.isOn)!
                    {
                        PSDataManager.sharedInstance.isRememberMe = 1
                        print("isRememberMe ON")
                        //                    PSDataManager.sharedInstance.loggedInUser = user
                    }
                    else
                    {
                        PSDataManager.sharedInstance.isRememberMe = 0
                        print("isRememberMe Off")
                        //                    PSDataManager.sharedInstance.loggedInUser = user
                    }
                    
//                    if user?.employeeType == "Reviewers"
//                    {
//                        PSDataManager.sharedInstance.loggedInUser?.userType = UserType(rawValue: 1)!
//                    }
//                    else
//                    {
//                        PSDataManager.sharedInstance.loggedInUser?.userType = UserType(rawValue: 0)!
//                    }
                    
                    self.getReportTypes()
                    
            } , failure:
                
                {
                    (error:NSError,statusCode:Int) in
                    PSUserInterfaceManager.sharedInstance.hideLoader()
                    if(statusCode==404)
                    {
                        PSUserInterfaceManager.showAlert(title: "Login Failure", message: ApiResultFailureMessage.InvalidEmailPassword)
                    }
                    else
                    {
                        PSUserInterfaceManager.showAlert(title: "Login Failure", message: error.localizedDescription)
                    }
                    
            }, errorPopup: true)
        }
        else
        {
            PSUserInterfaceManager.showAlert(title: "Login", message: ApiErrorMessage.NoNetwork)
        }
    }
    
    func getLocationsforReport() -> Void
    {
        if CEReachabilityManager.isReachable()
        {
            let companyId = (self.loggedInUser?.companyId)!
            PSAPIManager.sharedInstance.getLocationsFor(companyId: String(companyId) ,success:
            { (dic) in
                
                PSUserInterfaceManager.sharedInstance.hideLoader()
                let tempArray = dic["array"] as! [Any]
                
                for checklistDict in tempArray
                {
                    if let tempDict = checklistDict as? [String: Any]
                    {
                        self.locationsArray.append(tempDict)
                    }
                }
                
                PSDataManager.sharedInstance.companyLocationsArray = self.locationsArray
                self.saveCompanyLocations()
                if self.loggedInUser?.passwordChanged == 0
                {
                    self.performSegue(withIdentifier: "NavigateToCreatePassword", sender: Any?.self)
                }
                else
                {
                    PSDataManager.sharedInstance.loggedInUser = self.loggedInUser
                    self.performSegue(withIdentifier: "NavigateToDashboard", sender: Any?.self)
                }
                    
            }, failure:
                
            {
                (error:NSError,statusCode:Int) in
                PSUserInterfaceManager.sharedInstance.hideLoader()
                
                if PSDataManager.sharedInstance.loggedInUser?.passwordChanged == 0
                {
                    self.performSegue(withIdentifier: "NavigateToCreatePassword", sender: Any?.self)
                }
                else
                {
                    self.performSegue(withIdentifier: "NavigateToDashboard", sender: Any?.self)
                }
                
                if(statusCode==404)
                {
                    PSUserInterfaceManager.showAlert(title: "Locations", message: ApiErrorMessage.ErrorOccured)
                }
                else
                {
                    
                }
                    
            }, errorPopup: true)
        }
        else
        {
            
        }
    }
    
    func saveCompanyLocations()
    {
        let companyLocationsData = NSKeyedArchiver.archivedData(withRootObject: self.locationsArray)
        UserDefaults.standard.set(companyLocationsData, forKey: "CompanyLocations")
        
    }
    
    func getReportTypes ()
    {
        if CEReachabilityManager.isReachable()
        {
            let companyId = self.loggedInUser?.companyId as! Int
            PSAPIManager.sharedInstance.getAllChecklistsForCompanyID(CompanyID: String(companyId), success:
                { (dic) in
//                    PSUserInterfaceManager.sharedInstance.hideLoader()
                    let tempArray = dic["array"] as! [Any]
                    
                    for checklistDict in tempArray
                    {
                        if let tempDict = checklistDict as? [String: Any]
                        {
                            var checklist = PSChecklist(incidentType: 0, typeName: "", checkList: 0, checklistDetails: NSDictionary())
                            checklist = checklist.initChecklistWithDictionary(dict: tempDict as NSDictionary)
                            self.cheklistArray.append(checklist)
                        }
                    }
                    self.saveReportTypes()
                    self.getLocationsforReport()
                    print(self.cheklistArray)
                    
            }, failure:
                
                {
                    (error:NSError,statusCode:Int) in
                    PSUserInterfaceManager.sharedInstance.hideLoader()
                    if(statusCode==404)
                    {
                        PSUserInterfaceManager.showAlert(title: "Fetching Incident Types", message: ApiErrorMessage.ErrorOccured)
                    }
                    else
                    {
                        
                    }
                    
            }, errorPopup: true)
        }
        else
        {
            
        }
    }
    
    func getDeviceToken()
    {
        // You can retrieve the token directly using instanceIDWithHandler:. This callback provides an InstanceIDResult, which contains the token. A non null error is provided if the InstanceID retrieval failed in any way
        
        InstanceID.instanceID().instanceID
        { (result, error) in
        
            if let error = error
            {
                print("Error fetching remote instange ID: \(error)")
            }
            else if let result = result
            {
                print("Remote instance ID token: \(result.token)")
                
                DispatchQueue.global(qos: .background).async
                {
                    if let employeeId = self.loggedInUser?.employeeId
                    {
                        
                        PSAPIManager.sharedInstance.updateDeviceTokenFor(EmployeeID: String(employeeId), DeviceToken: result.token, success:
                        { (dict) in
                            
                            
                        }, failure:
                            
                        { (error, statusCode) in
                            
                            
                        }, errorPopup: true)
                    }
                }
            }
        }
        
    }
    
    func saveReportTypes()
    {
        let placesData = NSKeyedArchiver.archivedData(withRootObject: self.cheklistArray)
        UserDefaults.standard.set(placesData, forKey: "ReportTypes")
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if  segue.identifier == "NavigateToCreatePassword"
        {
            let vc = segue.destination as! PSCreatePasswordViewController
            vc.loggedInUser = self.loggedInUser
        }
    }
 

}
