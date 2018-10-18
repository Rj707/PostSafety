//
//  ReportSummaryViewController.swift
//  PostSafety
//
//  Created by Pasha on 18/05/2018.
//  Copyright © 2018 Now Tel. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class PSReportSummaryViewController: UIViewController,UITextViewDelegate
{
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var locationNameLabel: UILabel!
    @IBOutlet weak var reportTypleLabel: UILabel!
    @IBOutlet weak var subCategoryNameLabel: UILabel!
    @IBOutlet weak var isPSILabel: UILabel!
    
    @IBOutlet weak var decriptionTextView: IQTextView!
    @IBOutlet weak var decriptionTextViewContainer: UIView!
    @IBOutlet weak var backgroundView: UIView!
    var locationID = 0
    var IsPSI : NSNumber = 0
    
    override func viewDidLoad()
        
    {
        super.viewDidLoad()

        print(PSDataManager.sharedInstance.report?.reportType ?? "Type")
        print(PSDataManager.sharedInstance.report?.reportLocation ?? "Location")
        print(PSDataManager.sharedInstance.report?.reportCategory ?? "Category")
        print(PSDataManager.sharedInstance.report?.reportSubcategory ?? "Subcategory")
        
        reportTypleLabel.text = String(format: "Post Type: %@", (PSDataManager.sharedInstance.report?.reportType)!)
        locationNameLabel.text = String(format: "Post Location: %@", (PSDataManager.sharedInstance.report?.reportLocation)!)
        categoryNameLabel.text = String(format: "Category: %@", (PSDataManager.sharedInstance.report?.reportCategory)!)
        
        IsPSI = NSNumber.init(booleanLiteral: false)
        
        if PSDataManager.sharedInstance.report?.reportType == "Incident"
        {
            subCategoryNameLabel.isHidden =  true
            isPSILabel.isHidden =  true
        }
        else if PSDataManager.sharedInstance.report?.reportType == "NearMiss"
        {
            reportTypleLabel.text = "Post Type: Near Miss"
            subCategoryNameLabel.isHidden =  false
            isPSILabel.isHidden =  false
            isPSILabel.text = String(format: "PSI?: %@", (PSDataManager.sharedInstance.report?.isReportPSI)!)
            subCategoryNameLabel.text = String(format: "Subcategory: %@", (PSDataManager.sharedInstance.report?.reportSubcategory)!)
            if PSDataManager.sharedInstance.report?.isReportPSI == "Yes"
            {
                IsPSI = NSNumber.init(booleanLiteral: true)
            }
            else
            {
                IsPSI = NSNumber.init(booleanLiteral: false)
            }
        }
        else
        {
            subCategoryNameLabel.isHidden =  true
            isPSILabel.isHidden =  true
        }
        
        reportTypleLabel.text = reportTypleLabel.text?.components(separatedBy: .newlines).joined()
        locationNameLabel.text = locationNameLabel.text?.components(separatedBy: .newlines).joined()
        categoryNameLabel.text = categoryNameLabel.text?.components(separatedBy: .newlines).joined()
        isPSILabel.text = isPSILabel.text?.components(separatedBy: .newlines).joined()
        subCategoryNameLabel.text = subCategoryNameLabel.text?.components(separatedBy: .newlines).joined()
        
        self.backgroundView.layer.borderWidth=1
        self.backgroundView.layer.borderColor = UIColor(red:255/255, green:75/255, blue:1/255, alpha: 1).cgColor
        
        self.decriptionTextViewContainer.layer.borderWidth=1
        self.decriptionTextViewContainer.layer.borderColor = UIColor(red:255/255, green:75/255, blue:1/255, alpha: 1).cgColor
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
    
    @IBAction func sendReportButtonTouched(_ sender: Any)
    {
        if CEReachabilityManager.isReachable()
        {
            var report = PSReport.init()
            report = PSDataManager.sharedInstance.report!
            PSUserInterfaceManager.sharedInstance.showLoaderWithText(text: "Updating Report")
            PSAPIManager.sharedInstance.updateReportFor(ReportId: String(report.reportID), LocationId: String(locationID), Title: "", Details: self.decriptionTextView.text, CatagoryId: String(report.categoryID), SubCatagory: String(report.subCategoryID), IsPSI: self.IsPSI as! Bool, success:
            { (dict) in
                PSUserInterfaceManager.sharedInstance.hideLoader()
                /*** Moved that below line to NotifiPost API ***/
                //                PSDataManager.sharedInstance.report = PSReport.init()
                self.performSegue(withIdentifier: "toReportConfirmFromSummary", sender: (Any).self)
                
            },
                                                        failure:
            { (error, stausCode) in
                
            }, errorPopup: true)
            
            
        }
        else
        {
            self.performSegue(withIdentifier: "toNoInternetFromSummary", sender: (Any).self)
            print(PSDataManager.sharedInstance.offlinePostDictionary)

            
            // TODO: Offline Post Submisison
            PSDataManager.sharedInstance.offlinePostDictionary.setValue(self.decriptionTextView.text, forKey: "Details")
//            print(PSDataManager.sharedInstance.offlinePostDictionary)
            var post : PSPost?
            post = PSPost.init()
            post = post?.initWithDictionary(dict: PSDataManager.sharedInstance.offlinePostDictionary as NSDictionary)
            PSDataManager.sharedInstance.offlinePost = post

        }
    }
    
    
    // MARK: - UITextViewDelegate
    
    public func textViewShouldBeginEditing(_ textView: UITextView) -> Bool
    {
        return true
    }
    
    public func textViewShouldEndEditing(_ textView: UITextView) -> Bool
    {
        return true
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
