//
//  SendAlertViewController.swift
//  PostSafety
//
//  Created by Pasha on 24/06/2018.
//  Copyright © 2018 Now Tel. All rights reserved.
//

import UIKit

class PSSendAlertViewController: UIViewController,PSSelectDialogViewControllerDelegate
{
    
    @IBOutlet weak var toTextField:UITextField!
    @IBOutlet weak var menuButton:UIButton!
    @IBOutlet weak var sendButton:UIButton!
    var reportSenderArray = [NSMutableDictionary]()
    var EmployeeID = 0
    var ReportID = 0
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.addMenuAction()
        // Do any additional setup after loading the view.
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
    
    @IBAction func sendButtonTouched(_ sender: UIButton)
    {
        self.sendReport()
    }
    
    @IBAction func toTextFieldTouched(_ sender: UITapGestureRecognizer)
    {
        self.definesPresentationContext = true;
        let selectDialogVC : PSSelectDialogViewController
        selectDialogVC = self.storyboard?.instantiateViewController(withIdentifier: "PSSelectDialogViewController") as! PSSelectDialogViewController
        selectDialogVC.view.backgroundColor = UIColor.clear
        selectDialogVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        selectDialogVC.delegate = self
        selectDialogVC.shareReport = 0
        //        self.view.backgroundColor = UIColor.clear
        //        self.modalPresentationStyle = UIModalPresentationStyle.currentContext
        self.present(selectDialogVC, animated: true)
        {
            
        }
    }
    
    func addMenuAction()
    {
        if self.revealViewController() != nil
        {
            menuButton.addTarget(self.revealViewController(), action: #selector(self.revealViewController().revealToggle(_:)), for: .touchUpInside)
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
            let menuVC = revealViewController().rearViewController as? MenuViewController
            
            menuVC?.dashboardNavViewController = self.navigationController
        }
    }
    
    func sendReport()
    {
        if CEReachabilityManager.isReachable()
        {
            PSUserInterfaceManager.sharedInstance.showLoaderWithText(text: "Sending Reports")
//            EmployeeID = (PSDataManager.sharedInstance.loggedInUser?.employeeId)!
            ReportID = (PSDataManager.sharedInstance.reportId)
            PSAPIManager.sharedInstance.sendReportsWith(ReportID: String(ReportID), EmployeeID: String(EmployeeID), success:
            { (dic) in
                
                PSUserInterfaceManager.sharedInstance.hideLoader()
                
                if dic["SUCCESS"] as! String == "Done"
                {
                    
                }
                
                let alertController = UIAlertController(title: "Sending Report", message: "You have successfully Sent the report", preferredStyle: .alert)
                let alertActionCancel = UIAlertAction(title: "OK", style: .cancel)
                { (action) in
                    
                    self.navigationController?.popViewController(animated: true)
                    self.navigationController?.presentingViewController?.dismiss(animated: true)
                    {
                        
                    }
                }
                alertController.addAction(alertActionCancel)
                self.present(alertController, animated: true, completion: nil)
                    
            },
                                                            failure:
            { (
                error:NSError,statusCode:Int) in
                
                PSUserInterfaceManager.sharedInstance.hideLoader()
                if(statusCode==404)
                {
                    PSUserInterfaceManager.showAlert(title: "Sending Reports", message: ApiErrorMessage.ErrorOccured)
                }
                else
                {
                    PSUserInterfaceManager.showAlert(title: "Sending Reports", message: error.localizedDescription)
                }
                    
            }, errorPopup: true)
        }
    }
    
    //MARK: - PSSelectDialogViewControllerDelegate
    
    func reportSendersSelected(senders: [NSMutableDictionary])
    {
        self.reportSenderArray = senders
        self.configureSenders()
        self.sendButton.isUserInteractionEnabled = true
        self.sendButton.isEnabled = true
    }
    
    func configureSenders()
    {
        for i in 0...self.reportSenderArray.count-1
        {
            var reporterDict = NSMutableDictionary.init()
            reporterDict = reportSenderArray[i]
            
            toTextField.text = toTextField.text! + String(format: "%@%@", reporterDict["employeeFullName"] as! String, ",")
            EmployeeID = reporterDict["employeeId"] as! Int
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
