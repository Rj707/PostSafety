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
    @IBOutlet weak var menuButton:UIButton!
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
        
        self.addMenuAction()
        
        self.configureAndInitialize()
        
        self.getReportTypes()
    }
    
    func configureAndInitialize()
    {
        self.view1.layer.borderWidth=1
        self.view2.layer.borderWidth=1
        self.view3.layer.borderWidth=1
        self.view4.layer.borderWidth=1
        self.view1.layer.borderColor = UIColor(red:255/255, green:75/255, blue:1/255, alpha: 1).cgColor
        self.view2.layer.borderColor = UIColor(red:255/255, green:75/255, blue:1/255, alpha: 1).cgColor
        self.view3.layer.borderColor = UIColor(red:255/255, green:75/255, blue:1/255, alpha: 1).cgColor
        self.view4.layer.borderColor = UIColor(red:255/255, green:75/255, blue:1/255, alpha: 1).cgColor
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - APIs
    
    func getReportTypes ()
    {
        if CEReachabilityManager.isReachable()
        {
            PSUserInterfaceManager.sharedInstance.showLoaderWithText(text: "Fetching Incident Types")
            PSAPIManager.sharedInstance.getAllChecklists(success:
                { (dic) in
                    PSUserInterfaceManager.sharedInstance.hideLoader()
                    let tempArray = dic["array"] as! [Any]
                    
                    for checklistDict in tempArray
                    {
                        if let tempDict = checklistDict as? [String: Any]
                        {
                            var checklist = PSChecklist(incidentType: 0, typeName: "", checkList: 0, checklistDetails: NSDictionary())
                            checklist = checklist.initChecklistWithDictionary(dict: tempDict as NSDictionary)
                            self.cheklistArray.append(checklist)
                        }
                    }
                    self.saveReportTypes()
                    self.configureReportTypes()
                    print(self.cheklistArray)
                    
            }, failure:
                
                {
                    (error:NSError,statusCode:Int) in
                    PSUserInterfaceManager.sharedInstance.hideLoader()
                    if(statusCode==404)
                    {
                        PSUserInterfaceManager.showAlert(title: "Fetching Incident Types", message: ApiErrorMessage.ErrorOccured)
                    }
                    else
                    {
                        PSUserInterfaceManager.showAlert(title: "Fetching Incident Types", message: error.localizedDescription)
                    }
                    
            }, errorPopup: true)
        }
        else
        {
            PSUserInterfaceManager.showAlert(title: "Checklist", message: ApiErrorMessage.NoNetwork)
            self.loadReportTypes()
        }
    }
    
    func saveReportTypes()
    {
        let placesData = NSKeyedArchiver.archivedData(withRootObject: self.cheklistArray)
        UserDefaults.standard.set(placesData, forKey: "ReportTypes")
        
    }

    func loadReportTypes()
    {
        let placesData = UserDefaults.standard.value(forKey: "ReportTypes") as? Data
        
        if let placesData = placesData
        {
            let placesArray = NSKeyedUnarchiver.unarchiveObject(with: placesData as Data) as! [PSChecklist]
            
            if placesArray != nil
            {
                // do something…
                self.cheklistArray = placesArray as [Any]
                self.configureReportTypes()
            }
            
        }
        
    }
    
    // MARK: - Private
    
    func configureReportTypes() -> Void
    {
        for i in 0...self.cheklistArray.count-1
        {
            var item = PSChecklist(incidentType: 0, typeName: "", checkList: 0, checklistDetails: NSDictionary())
            item = cheklistArray[i] as! PSChecklist
            
            switch item.incidentType
            {
                
                case 1  :
                print(item.typeName ?? "")
                self.label4.text = item.typeName
                self.label4.tag = item.incidentType
                break
                case 2  :
                print(item.typeName ?? "")
                self.label1.text = item.typeName
                self.label1.tag = item.incidentType
                break
                case 3  :
                print(item.typeName ?? "")
                self.label3.text = item.typeName
                self.label3.tag = item.incidentType
                break
                default :
                print(item.typeName ?? "")
                self.label2.text = item.typeName
                self.label2.tag = item.incidentType
                break
            }
        }
    }
    
    func setCheckListForReporType(reportType:Int) -> PSChecklist
    {
        for i in 1...self.cheklistArray.count-1
        {
            var item = PSChecklist(incidentType: 0, typeName: "", checkList: 0, checklistDetails: NSDictionary())
            item = cheklistArray[i] as! PSChecklist
            
            if item.incidentType == reportType
            {
                return item;
            }
            
        }
        return PSChecklist(incidentType: 0, typeName: "", checkList: 0, checklistDetails: NSDictionary())
    }
    
    // MARK: - IBActions
    
    @IBAction func backButtonTouched(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }

    
    @IBAction func hazardGestureTapped(_ sender: Any)
    {
        PSDataManager.sharedInstance.report?.reportType = "Hazard"
        PSDataManager.sharedInstance.report?.incidentType = self.label1.tag
        
        let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "TakePhotoVideoViewController") as! TakePhotoVideoViewController
        vc.incidentTypeID = self.label1.tag
        vc.employeeID = (PSDataManager.sharedInstance.loggedInUser?.employeeId)!
        vc.checkList = self.setCheckListForReporType(reportType: vc.incidentTypeID)
        navigationController?.pushViewController(vc,
                                                 animated: true)
    }
    @IBAction func incidentGestureTapped(_ sender: Any)
    {
        PSDataManager.sharedInstance.report?.reportType = "Incident"
        PSDataManager.sharedInstance.report?.incidentType = self.label3.tag
        
        let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "TakePhotoVideoViewController") as! TakePhotoVideoViewController
        vc.incidentTypeID = self.label3.tag
        vc.employeeID = (PSDataManager.sharedInstance.loggedInUser?.employeeId)!
        vc.checkList = self.setCheckListForReporType(reportType: vc.incidentTypeID)
        navigationController?.pushViewController(vc,
                                                 animated: true)
 
    }
    @IBAction func nearMisstGestureTapped(_ sender: Any)
    {
        PSDataManager.sharedInstance.report?.reportType = "NearMiss"
        PSDataManager.sharedInstance.report?.incidentType = self.label2.tag
        
        let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "TakePhotoVideoViewController") as! TakePhotoVideoViewController
        vc.incidentTypeID = self.label2.tag
        vc.employeeID = (PSDataManager.sharedInstance.loggedInUser?.employeeId)!
        vc.checkList = self.setCheckListForReporType(reportType: vc.incidentTypeID)
        navigationController?.pushViewController(vc,
                                                 animated: true)
        
    }
    @IBAction func emergencyGestureTapped(_ sender: Any)
    {
        PSDataManager.sharedInstance.report?.incidentType = self.label4.tag
        PSDataManager.sharedInstance.report?.reportType = "Emergency"
        print(PSDataManager.sharedInstance.report?.reportType ?? "No Type Found")
        let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PSEmergencyInstructionsViewController") as! PSEmergencyInstructionsViewController
        navigationController?.pushViewController(vc,
                                                 animated: true)
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
   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
