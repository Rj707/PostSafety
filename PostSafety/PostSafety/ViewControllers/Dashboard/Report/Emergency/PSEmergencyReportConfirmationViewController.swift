//
//  PSEmergencyReportConfirmationViewController.swift
//  PostSafety
//
//  Created by Rayyan on 24/06/2018.
//  Copyright © 2018 Now Tel. All rights reserved.
//

import UIKit

class PSEmergencyReportConfirmationViewController: UIViewController
{

    @IBOutlet weak var confirmationContainer:UIView!
    public var delegate:PSEmergencyReportConfirmationViewControllerDelegate!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.confirmationContainer.layer.borderWidth=2
        self.confirmationContainer.layer.borderColor = UIColor(red:255/255, green:75/255, blue:1/255, alpha: 1).cgColor
        DispatchQueue.global(qos: .background).async
        {
            self.notifyPost()
        }
        
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - IBActions
    
    @IBAction func call911ButtonTouched(_ sender: UIButton)
    {
        var phone = "911"
        phone = phone.removingWhitespaces()
        var newPhone = ""
        for i in (phone.characters)
        {
            switch (i)
            {
            case "0","1","2","3","4","5","6","7","8","9" : newPhone = newPhone + String(i)
            default : print("Removed invalid character.")
            }
        }
        
        if let url = URL(string:"tel://\(String(describing: newPhone))"), UIApplication.shared.canOpenURL(url)
        {
            UIApplication.shared.openURL(url)
        }
        else
        {
            print("Issue")
        }
    }
    
    @IBAction func takeAnotherVideoButtonTouched(_ sender: UIButton)
    {
        
        if let viewControllers = self.navigationController?.viewControllers
        {
            for viewController in viewControllers
            {
                // some process
                if viewController is TakePhotoVideoViewController
                {
                    self.delegate.takeAnotherVideoForEmergency()
                    self.navigationController?.popToViewController(viewController, animated: true)
                    return
                }
            }
        }
    }
    
    @IBAction func returnToDashboardButtonTouched(_ sender: UIButton)
    {
        PSDataManager.sharedInstance.report = PSReport.init()
        if let viewControllers = self.navigationController?.viewControllers
        {
            for viewController in viewControllers
            {
                // some process
                if viewController is PSDashboardViewController
                {
                    self.navigationController?.popToViewController(viewController, animated: true)
                    break
                }
            }
        }
    }
    
    func notifyPost ()
    {
        if CEReachabilityManager.isReachable()
        {
//            var report = PSReport.init()
//            report = PSDataManager.sharedInstance.report!
            let reportID = PSDataManager.sharedInstance.report?.reportID as! Int
            PSAPIManager.sharedInstance.NotifyPostFor(reportID: String(reportID), success:
            { (dict) in
                
                
            },
                                                      failure:
                { (error, stausCode) in
                    
            }, errorPopup: true)
            
            
        }
        else
        {
            
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

protocol PSEmergencyReportConfirmationViewControllerDelegate
{
    func takeAnotherVideoForEmergency()
    func takeAnotherOfflineVideoForEmergency()
}
