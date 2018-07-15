//
//  ReportSummaryViewController.swift
//  PostSafety
//
//  Created by Pasha on 18/05/2018.
//  Copyright © 2018 Now Tel. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class PSReportSummaryViewController: UIViewController
{
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var locationNameLabel: UILabel!
    @IBOutlet weak var reportTypleLabel: UILabel!
    
    @IBOutlet weak var decriptionTextView: IQTextView!
    @IBOutlet weak var decriptionTextViewContainer: UIView!
    @IBOutlet weak var backgroundView: UIView!
     var locationID = 0
    override func viewDidLoad()
    {
        super.viewDidLoad()

        print(Global.REPORT?.reportType ?? "Type")
        print(Global.REPORT?.reportLocation ?? "Location")
        print(Global.REPORT?.reportCategory ?? "Category")
        print(Global.REPORT?.reportSubcategory ?? "Subcategory")
        
        reportTypleLabel.text=Global.REPORT?.reportType
        locationNameLabel.text=Global.REPORT?.reportLocation
        categoryNameLabel.text=Global.REPORT?.reportCategory
        
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
    
    func setDateTimeForReport()
    {
//        let date = Date()
//        let formatter = DateFormatter()
////        Give the format you want to the formatter:
//        
//        formatter.dateFormat = "dd.MM.yyyy"
////        Get the result string:
//        
//        var result = formatter.string(from: date)
////        Set your label:
//        
//        self.dateTextField.text = result
//        
//        formatter.dateFormat = "hh:mm a"
//        result = formatter.string(from: date)
//        self.timeTextField.text = result
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
            report = Global.REPORT!
            PSAPIManager.sharedInstance.updateReportFor(ReportId: String(report.reportID), LocationId: String(locationID), Title: "", Details: self.decriptionTextView.text, CatagoryId: String(report.categoryID), SubCatagory: "0", success:
            { (dict) in
                Global.REPORT = PSReport.init()
                self.performSegue(withIdentifier: "toReportConfirmFromSummary", sender: (Any).self)
                
            },
                                                        failure:
            { (error, stausCode) in
                
            }, errorPopup: true)
            
            
        }
        else
        {
            self.performSegue(withIdentifier: "toNoInternetFromSummary", sender: (Any).self)
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
