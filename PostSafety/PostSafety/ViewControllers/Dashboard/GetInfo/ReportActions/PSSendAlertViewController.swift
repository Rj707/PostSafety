//
//  SendAlertViewController.swift
//  PostSafety
//
//  Created by Pasha on 24/06/2018.
//  Copyright © 2018 Now Tel. All rights reserved.
//

import UIKit

class PSSendAlertViewController: UIViewController,PSSelectDialogViewControllerDelegate,UITextViewDelegate
{
    
    @IBOutlet weak var toTextField:UITextField!
    @IBOutlet weak var subjectTextField:UITextField!
    @IBOutlet weak var messageTextView:UITextView!
    @IBOutlet weak var menuButton:UIButton!
    @IBOutlet weak var sendButton:UIButton!
    var reportSenderArray = [NSMutableDictionary]()
    var EmployeeID = ""
    var ReportID = 0
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.messageTextView.delegate = self
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
        self.createAlert()
    }
    
    @IBAction func toTextFieldTouched(_ sender: UITapGestureRecognizer)
    {
        self.definesPresentationContext = true;
        let selectDialogVC : PSShareReportViewController
        selectDialogVC = self.storyboard?.instantiateViewController(withIdentifier: "PSShareReportViewController") as! PSShareReportViewController
        selectDialogVC.view.backgroundColor = UIColor.clear
        selectDialogVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        selectDialogVC.delegate = self
        selectDialogVC.shareReport = 0

        self.present(selectDialogVC, animated: true)
        {
            
        }
    }
    
    func addMenuAction()
    {
        if self.revealViewController() != nil
        {
            menuButton.addTarget(self.revealViewController(), action: #selector(self.revealViewController().rightRevealToggle(_:)), for: .touchUpInside)
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
            let menuVC = revealViewController().rearViewController as? MenuViewController
            
            menuVC?.dashboardNavViewController = self.navigationController
        }
    }
    
    func createAlert()
    {
        if self.subjectTextField.text == ""
        {
            PSUserInterfaceManager.showAlert(title: "Creating Alert", message: "Please enter alert subject")
        }
        else if self.messageTextView.text == ""
        {
            PSUserInterfaceManager.showAlert(title: "Creating Alert", message: "Please enter alert message")
        }
        else if CEReachabilityManager.isReachable()
        {
            PSUserInterfaceManager.sharedInstance.showLoaderWithText(text: "Creating Alert")
            let employeeId = (PSDataManager.sharedInstance.loggedInUser?.employeeId)!
            ReportID = (PSDataManager.sharedInstance.reportId)
            PSAPIManager.sharedInstance.createAlertWith(EmployeeId: String(employeeId), Title: self.subjectTextField.text!, Body: self.messageTextView.text, Employees: self.EmployeeID, success:
            { (dic) in
                
                PSUserInterfaceManager.sharedInstance.hideLoader()
                
                if dic["ReportID"] as! Int != 0
                {
                    
                }
                
                let alertController = UIAlertController(title: "Sending Alert", message: "You have successfully sent the alert", preferredStyle: .alert)
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
                    PSUserInterfaceManager.showAlert(title: "Sending Alert", message: ApiErrorMessage.ErrorOccured)
                }
                else
                {
                    PSUserInterfaceManager.showAlert(title: "Sending Alert", message: error.localizedDescription)
                }
                    
            }, errorPopup: true)
        }
        else
        {
            PSUserInterfaceManager.showAlert(title: "Sending Alert", message: ApiErrorMessage.NoNetwork)
        }
    }
    
    // MARK: - UITextViewDelegate
    
    public func textViewShouldBeginEditing(_ textView: UITextView) -> Bool
    {
        textView.text = ""
        return true
    }
    
    public func textViewShouldEndEditing(_ textView: UITextView) -> Bool
    {
        if textView.text == ""
        {
            textView.text = "Message"
        }
        return true
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
        var temp = ""
        temp = String(PSDataManager.sharedInstance.loggedInUser?.employeeId as! Int)
        temp =  temp + ";"
        for i in 0...self.reportSenderArray.count-1
        {
            var reporterDict = NSMutableDictionary.init()
            reporterDict = reportSenderArray[i]
            
            if i != self.reportSenderArray.count-1
            {
                toTextField.text = toTextField.text! + String(format: "%@%@", reporterDict["employeeFullName"] as! String, ", ")
            }
            else
            {
                toTextField.text = toTextField.text! + String(format: "%@", reporterDict["employeeFullName"] as! String)
            }
            
            temp = temp + String(self.reportSenderArray[i].value(forKey: "employeeId") as! Int)
            if i != self.reportSenderArray.count-1
            {
                temp =  temp + ";"
            }
        }
        
        EmployeeID = temp
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
