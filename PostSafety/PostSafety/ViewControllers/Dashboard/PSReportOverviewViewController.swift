//
//  QuickSummaryViewController.swift
//  PostSafety
//
//  Created by Pasha on 18/05/2018.
//  Copyright © 2018 Now Tel. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class PSReportOverviewViewController: UIViewController
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
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
        
        self.timeLable.text = self.reportOverviewDict["date"] is NSNull ? "None" : self.reportOverviewDict["date"] as! String
        self.dateLable.text = self.reportOverviewDict["date"] is NSNull ? "None" : self.reportOverviewDict["date"] as! String
        self.reporterLable.text = self.reportOverviewDict["reportedBy"] is NSNull ? "None" : String(self.reportOverviewDict["reportedBy"] as! Int)
        self.locationLable.text = self.reportOverviewDict["location"] is NSNull ? "None" : self.reportOverviewDict["location"] as! String
        self.typeLable.text = self.reportOverviewDict["incidentType"] is NSNull ? "None" : String(self.reportOverviewDict["incidentType"] as! Int)
        self.subCategoryLable.text = self.reportOverviewDict["subCatagoryId"] is NSNull ? "None" : String(self.reportOverviewDict["subCatagoryId"] as! Int)
        self.categoryLable.text = self.reportOverviewDict["catagoryId"] is NSNull ? "None" : String(self.reportOverviewDict["catagoryId"] as! Int)
        self.reporterPhoneNumberLable.text = self.reportOverviewDict["reportedByNavigation"] is NSNull ? "None" : self.reportOverviewDict["reportedByNavigation"] as! String
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
