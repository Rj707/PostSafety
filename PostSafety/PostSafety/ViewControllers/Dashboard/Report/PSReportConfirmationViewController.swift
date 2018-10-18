//
//  ReportConfirmationViewController.swift
//  PostSafety
//
//  Created by Hafiz Saad on 16/05/2018.
//  Copyright © 2018 Now Tel. All rights reserved.
//

import UIKit

class PSReportConfirmationViewController: UIViewController
{

    @IBOutlet weak var confirmationContainer:UIView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.confirmationContainer.layer.borderWidth = 2
        self.confirmationContainer.layer.borderColor = UIColor(red:255/255, green:75/255, blue:1/255, alpha: 1).cgColor
        
        
        DispatchQueue.global(qos: .background).async
        {
            self.notifyPost()
        }
//        DispatchQueue.main.async
//        {
//            print("This is run on the main queue, after the previous code in outer block")
//        }
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - IBActions
    
    @IBAction func backButtonTouched(_ sender: UIButton)
    {
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
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func returnToDashboardButtonTouched(_ sender: UIButton)
    {
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
            let reportID = PSDataManager.sharedInstance.report?.reportID as! Int
            PSAPIManager.sharedInstance.NotifyPostFor(reportID: String(reportID), success:
            { (dict) in
                
                PSDataManager.sharedInstance.report = PSReport.init()
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
