//
//  SelectReportTypeViewController.swift
//  PostSafety
//
//  Created by Hafiz Saad on 16/05/2018.
//  Copyright © 2018 Now Tel. All rights reserved.
//

import UIKit

class PSSelectReportTypeViewController: UIViewController
{
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view1: UIView!
    
    @IBOutlet weak var label4: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label1: UILabel!

    var cheklistArray = [Any]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.view1.layer.borderWidth=1
        self.view2.layer.borderWidth=1
        self.view3.layer.borderWidth=1
        self.view4.layer.borderWidth=1
        self.view1.layer.borderColor = UIColor(red:255/255, green:75/255, blue:1/255, alpha: 1).cgColor
        self.view2.layer.borderColor = UIColor(red:255/255, green:75/255, blue:1/255, alpha: 1).cgColor
        self.view3.layer.borderColor = UIColor(red:255/255, green:75/255, blue:1/255, alpha: 1).cgColor
        self.view4.layer.borderColor = UIColor(red:255/255, green:75/255, blue:1/255, alpha: 1).cgColor
        
        PSAPIManager.sharedInstance.uploadImageFor(ReportId: "10005", Type: "Image", success:
        { (dic) in
            
            
            
        }, failure:
        { (error:NSError,statusCode:Int) in
            
            
            
        }, errorPopup: true)
        
//        if CEReachabilityManager.isReachable()
//        {
//            PSUserInterfaceManager.sharedInstance.showLoaderWithText(text: "Fetching Incident Types")
//            PSAPIManager.sharedInstance.getAllChecklists(success:
//            { (dic) in
//                PSUserInterfaceManager.sharedInstance.hideLoader()
//                let tempArray = dic["array"] as! [Any]
//
//                for checklistDict in tempArray
//                {
//                    if let tempDict = checklistDict as? [String: Any]
//                    {
//                        var checklist = PSChecklist()
//                        checklist = checklist.initChecklistWithDictionary(dict: tempDict as NSDictionary)
//                        self.cheklistArray.append(checklist)
//                    }
//                }
//
//                self.configureReportTypes()
//                print(self.cheklistArray)
//
//            }, failure:
//
//            {
//                (error:NSError,statusCode:Int) in
//                PSUserInterfaceManager.sharedInstance.hideLoader()
//                if(statusCode==404)
//                {
//                    PSUserInterfaceManager.showAlert(title: "Checklist", message: ApiResultFailureMessage.InvalidEmailPassword)
//                }
//                else
//                {
//
//                }
//
//            }, errorPopup: true)
//        }
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configureReportTypes() -> Void
    {
        for i in 0...self.cheklistArray.count-1
        {
            var item = PSChecklist.init()
            item = cheklistArray[i] as! PSChecklist
            
            switch item.incidentType
            {
                case 1  :
                self.label4.text = item.typeName
                self.label4.tag = item.incidentType
                case 2  :
                self.label1.text = item.typeName
                self.label1.tag = item.incidentType
                case 3  :
                self.label2.text = item.typeName
                self.label2.tag = item.incidentType
                default :
                self.label3.text = item.typeName
                self.label3.tag = item.incidentType
            }
        }
    }
    
    func setCheckListForReporType(reportType:Int) -> PSChecklist
    {
        for i in 1...self.cheklistArray.count-1
        {
            var item = PSChecklist.init()
            item = cheklistArray[i] as! PSChecklist
            
            if item.incidentType == reportType
            {
                return item;
            }
            
        }
        return PSChecklist.init()
    }
    
    // MARK: - IBActions
    
    @IBAction func backButtonTouched(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }

    
    @IBAction func hazardGestureTapped(_ sender: Any)
    {
        Global.REPORT?.reportType = "Hazard"
        let dict:[String:String] = ["reporttype":"Hazard"]
        UserDefaults.standard.set(dict, forKey: "dict")
        let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "TakePhotoVideoViewController") as! TakePhotoVideoViewController
        vc.incidentTypeID = self.label1.tag
        vc.checkList = self.setCheckListForReporType(reportType: vc.incidentTypeID)
        navigationController?.pushViewController(vc,
                                                 animated: true)
    }
    @IBAction func incidentGestureTapped(_ sender: Any)
    {
        Global.REPORT?.reportType = "Incident"
        let dict:[String:String] = ["reporttype":"Incident"]
        UserDefaults.standard.set(dict, forKey: "dict")
        let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "TakePhotoVideoViewController") as! TakePhotoVideoViewController
        vc.incidentTypeID = self.label2.tag
        vc.checkList = self.setCheckListForReporType(reportType: vc.incidentTypeID)
        navigationController?.pushViewController(vc,
                                                 animated: true)
 
    }
    @IBAction func nearMisstGestureTapped(_ sender: Any)
    {
        Global.REPORT?.reportType = "NearMiss"
        let dict:[String:String] = ["reporttype":"NearMiss"]
        UserDefaults.standard.set(dict, forKey: "dict")
        let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "TakePhotoVideoViewController") as! TakePhotoVideoViewController
        vc.incidentTypeID = self.label3.tag
        vc.checkList = self.setCheckListForReporType(reportType: vc.incidentTypeID)
        navigationController?.pushViewController(vc,
                                                 animated: true)
        
    }
    @IBAction func emergencyGestureTapped(_ sender: Any)
    {
        Global.REPORT?.reportType = "Emergency"
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
