//
//  PSCloseReportViewController.swift
//  PostSafety
//
//  Created by Rayyan on 24/06/2018.
//  Copyright © 2018 Now Tel. All rights reserved.
//

import UIKit

class PSCloseReportViewController: UIViewController
{
    @IBOutlet weak var closeReportContainer: UIView!
    
    var ReportId = 0
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.closeReportContainer.layer.borderWidth = 2
        self.closeReportContainer.layer.borderColor = UIColor(red:255/255, green:75/255, blue:1/255, alpha: 1).cgColor
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - IBActions
    
    @IBAction func crossButtonTouched(_ sender: UIButton)
    {
        self.dismiss(animated: true)
        {
            
        }
    }
    
    @IBAction func closeReportButtonTouched(_ sender: UIButton)
    {
        self.closeReport()
    }
    
    func closeReport ()
    {
        if CEReachabilityManager.isReachable()
        {
            PSUserInterfaceManager.sharedInstance.showLoaderWithText(text: "Closing Post")
            ReportId = (PSDataManager.sharedInstance.reportId)
            PSAPIManager.sharedInstance.closeReportWith(ReportId:String(ReportId), success:
            { (dic) in
                
                PSUserInterfaceManager.sharedInstance.hideLoader()
                
                if dic["SUCCESS"] as! String == "Done"
                {
                    
                    let alertController = UIAlertController(title: "Closing Post", message: "You have successfully closed the post", preferredStyle: .alert)
                    let alertActionCancel = UIAlertAction(title: "OK", style: .cancel)
                    { (action) in
                        
                        self.presentingViewController?.presentingViewController?.dismiss(animated: true)
                        {
                            
                        }
                    }
                    alertController.addAction(alertActionCancel)
                    self.present(alertController, animated: true, completion: nil)
                    
                    
                }

                
                
            } , failure:
                
                {
                    (error:NSError,statusCode:Int) in
                    PSUserInterfaceManager.sharedInstance.hideLoader()
                    if(statusCode==404)
                    {
                        PSUserInterfaceManager.showAlert(title: "Closing Post", message: ApiErrorMessage.ErrorOccured)
                    }
                    else
                    {
                        PSUserInterfaceManager.showAlert(title: "Closing Post", message: error.localizedDescription)
                    }
                    
            }, errorPopup: true)
        }
        else
        {
            PSUserInterfaceManager.showAlert(title: "Closing Post", message: ApiErrorMessage.NoNetwork)
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
