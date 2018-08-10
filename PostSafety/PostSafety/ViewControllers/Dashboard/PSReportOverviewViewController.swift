//
//  QuickSummaryViewController.swift
//  PostSafety
//
//  Created by Pasha on 18/05/2018.
//  Copyright © 2018 Now Tel. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import MessageUI

class PSReportOverviewViewController: UIViewController,MFMessageComposeViewControllerDelegate
{

    var reportOverviewDict = NSDictionary.init()
    
    @IBOutlet weak var typeLable: UILabel!
    @IBOutlet weak var categoryLable: UILabel!
    @IBOutlet weak var subCategoryLable: UILabel!
    @IBOutlet weak var locationLable: UILabel!
    @IBOutlet weak var dateLable: UILabel!
    @IBOutlet weak var timeLable: UILabel!
    @IBOutlet weak var reporterLable: UILabel!
    @IBOutlet weak var reporterPhoneNumberLable: UILabel!
    var alertController = UIAlertController()
    override func viewDidLoad()
    {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
        
        self.timeLable.text = self.reportOverviewDict["time"] is NSNull ? "None" : self.reportOverviewDict["time"] as! String
        self.dateLable.text = self.reportOverviewDict["date"] is NSNull ? "None" : self.reportOverviewDict["date"] as! String
        self.reporterLable.text = self.reportOverviewDict["reportedBy"] is NSNull ? "None" : self.reportOverviewDict["reportedBy"] as! String
        self.locationLable.text = self.reportOverviewDict["location"] is NSNull ? "None" : self.reportOverviewDict["location"] as! String
        self.typeLable.text = self.reportOverviewDict["incidentType"] is NSNull ? "None" : self.reportOverviewDict["incidentType"] as! String
        self.subCategoryLable.text = self.reportOverviewDict["subCatagory"] is NSNull ? "None" : self.reportOverviewDict["subCatagory"] as! String
        self.categoryLable.text = self.reportOverviewDict["catagory"] is NSNull ? "None" : self.reportOverviewDict["catagory"] as! String
        self.reporterPhoneNumberLable.text = self.reportOverviewDict["reportedByNumber"] is NSNull ? "None" : self.reportOverviewDict["reportedByNumber"] as! String
        
        
        self.timeLable.text = self.reportOverviewDict["time"] as! String == "" ? "N/A" : self.reportOverviewDict["time"] as! String
        self.dateLable.text = self.reportOverviewDict["date"] as! String == "" ? "N/A" : self.reportOverviewDict["date"] as! String
        self.reporterLable.text = self.reportOverviewDict["reportedBy"] as! String == "" ? "N/A" : self.reportOverviewDict["reportedBy"] as! String
        self.locationLable.text = self.reportOverviewDict["location"] as! String == "" ? "N/A" : self.reportOverviewDict["location"] as! String
        self.typeLable.text = self.reportOverviewDict["incidentType"] as! String == "" ? "N/A" : self.reportOverviewDict["incidentType"] as! String
        self.subCategoryLable.text = self.reportOverviewDict["subCatagory"] as! String == "" ? "N/A" : self.reportOverviewDict["subCatagory"] as! String
        self.categoryLable.text = self.reportOverviewDict["catagory"] as! String == "" ? "N/A" : self.reportOverviewDict["catagory"] as! String
        self.reporterPhoneNumberLable.text = self.reportOverviewDict["reportedByNumber"] as! String == "" ? "N/A" : self.reportOverviewDict["reportedByNumber"] as! String
        
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
    
    @IBAction func phoneNumberGestureTapped(_ sender: Any)
    {
        alertController = UIAlertController(title: "Post Overview", message: "Do you want to make a call or message to sender", preferredStyle: .alert)
        
        let alertActionCall = UIAlertAction(title: "Call", style: .default)
        { (action) in
            
            var phone = self.reporterPhoneNumberLable.text
            phone = phone?.removingWhitespaces()
            var newPhone = ""
            for i in (phone?.characters)!
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
        alertController.addAction(alertActionCall)
        let alertActionMessage = UIAlertAction(title: "Message", style: .default)
        { (action) in
            
            if (MFMessageComposeViewController.canSendText())
            {
                let controller = MFMessageComposeViewController()
                controller.body = "Message Body"
                controller.recipients = [self.reporterPhoneNumberLable.text] as? [String]
                controller.messageComposeDelegate = self
                DispatchQueue.main.async
                {
                    self.present(controller, animated: true, completion: nil)
                }
                
            }
            
        }
        
        alertController.addAction(alertActionMessage)
        
        self.present(alertController, animated: true)
        {
            var arrayof = self.alertController.view.superview?.subviews
            self.alertController.view.superview?.isUserInteractionEnabled = true
            self.alertController.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.alertControllerBackgroundTapped)))
        }
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult)
    {
        //... handle sms screen actions
        controller.dismiss(animated: true, completion: nil)
    }
    

    func alertControllerBackgroundTapped()
    {
        self.alertController.dismiss(animated: true, completion: nil)
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

extension String
{
    func removingWhitespaces() -> String
    {
        return components(separatedBy: .whitespaces).joined()
    }
}
