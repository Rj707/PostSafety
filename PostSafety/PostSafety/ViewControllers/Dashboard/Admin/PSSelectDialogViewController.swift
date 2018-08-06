//
//  SelectDialogViewController.swift
//  PostSafety
//
//  Created by Pasha on 24/06/2018.
//  Copyright © 2018 Now Tel. All rights reserved.
//

import UIKit

class PSSelectDialogViewController: UIViewController,UITableViewDelegate,UITableViewDataSource
{
    public var delegate:PSSelectDialogViewControllerDelegate!
    
    @IBOutlet weak var selectDialogTableView:UITableView!
    @IBOutlet weak var selectionButton:UIButton!
    @IBOutlet weak var doneButton:UIButton!
    @IBOutlet weak var searchBar:UISearchBar!
    @IBOutlet weak var selectionLabel:UILabel!
    
    var reportSenderArrayNew = [NSMutableDictionary]()
    var reportSenderArray = [String]()
    var reportSenderDetailArray = [Any]()
    var selectedPeopleArray = [String]()
    var companyId = 0
    var EmployeeID = 0
    var ReportID = 0
    
    var shareReport = 0
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.selectDialogTableView.dataSource = self
        self.selectDialogTableView.delegate = self
        self.getAllEmployees()
        searchBar.backgroundColor = UIColor.clear
        searchBar.backgroundImage = UIImage()
        searchBar.isTranslucent = true

        
        if self.shareReport == 0
        {
            self.doneButton.setTitle("Done", for: .normal)
        }
        else
        {
            self.doneButton.setTitle("Share Report", for: .normal)
        }
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getAllEmployees()
    {
        if CEReachabilityManager.isReachable()
        {
            PSUserInterfaceManager.sharedInstance.showLoaderWithText(text: "Fetching Senders")
            companyId = (PSDataManager.sharedInstance.loggedInUser?.companyId)!
            PSAPIManager.sharedInstance.listAllEmployeesFor(companyId: String(companyId), success:
                { (dic) in
                    PSUserInterfaceManager.sharedInstance.hideLoader()
                    let tempArray = dic["array"] as! [Any]
                    
                    for checklistDict in tempArray
                    {
                        if let tempDict = checklistDict as? [String: Any]
                        {
                            self.reportSenderDetailArray.append(tempDict)
                        }
                    }
                    
                    for i in 0...self.reportSenderDetailArray.count-1
                    {
                        var item = NSDictionary()
                        item = self.reportSenderDetailArray[i] as! NSDictionary
                        let employeeId = item["employeeId"] as! Int
                        self.reportSenderArray.append(String(employeeId))
                        self.selectedPeopleArray.append("")
                    }
                    
                    self.selectDialogTableView.reloadData()
                    print(self.reportSenderDetailArray)
                    
            }, failure:
                { (error:NSError,statusCode:Int) in
                    
                    PSUserInterfaceManager.sharedInstance.hideLoader()
                    if(statusCode==404)
                    {
                        PSUserInterfaceManager.showAlert(title: "Senders", message: ApiResultFailureMessage.InvalidEmailPassword)
                    }
                    else
                    {
                        
                    }
                    
            }, errorPopup: true)
        }
    }
    
    // MARK: - IBActions
    
    @IBAction func selectAllButtonTouched(_ sender: UITapGestureRecognizer)
    {
        if selectionButton.imageView?.image == (UIImage.init(named: "unselected"))
        {
            self.selectionLabel.text = "Unselect All"
            selectedPeopleArray = self.reportSenderArray
            self.selectionButton.setImage(UIImage.init(named: "selected"), for: UIControlState.normal)
        }
        else
        {
            self.selectionLabel.text = "Select All"
            selectedPeopleArray = [String]()
            self.configureSelectedPeopleArrayWithEmptyObjects()
            self.selectionButton.setImage(UIImage.init(named: "unselected"), for: UIControlState.normal)
        }
        
        selectDialogTableView.reloadData()
    }
    
    @IBAction func crossButtonTouched(_ sender: UIButton)
    {
        self.dismiss(animated: true)
        {
        }
    }
    
    @IBAction func doneButtonTouched(_ sender: UIButton)
    {
        self.self.reportSenderArrayNew = self.configureSelectedPeopleArrayForSelectedContacts()
        if self.delegate != nil
        {
            if self.reportSenderArrayNew.count>0
            {
                self.delegate.reportSendersSelected(senders: self.reportSenderArrayNew)
                self.dismiss(animated: true)
                {
                }
            }
            else
            {
                
            }
        }
        else
        {
            if self.reportSenderArrayNew.count>0
            {
                let alertController = UIAlertController(title: "Share Report", message: "Are you sure you want to share report with the Selected Contact", preferredStyle: .alert)
                
                let alertActionNo = UIAlertAction(title: "No", style: .cancel)
                { (action) in
                    
                }
                let alertActionYes = UIAlertAction(title: "Yes", style: .default)
                { (action) in
                    
                    self.EmployeeID = self.reportSenderArrayNew[0].value(forKey: "employeeId") as! Int
                    self.sendReport()
                }
                alertController.addAction(alertActionNo)
                alertController.addAction(alertActionYes)
                self.present(alertController, animated: true, completion: nil)
            }
            else
            {
                let alertController = UIAlertController(title: "Share Report", message: "Please first select any contact from the list", preferredStyle: .alert)
                
                let alertActionNo = UIAlertAction(title: "Ok", style: .cancel)
                { (action) in
                    
                }
            
                alertController.addAction(alertActionNo)
                self.present(alertController, animated: true, completion: nil)
            }
        }
        
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return reportSenderArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var cell:PSSelectDialogTableViewCell
        cell = tableView.dequeueReusableCell(withIdentifier: "SelectDialogCell", for: indexPath) as! PSSelectDialogTableViewCell
        cell.selectionNameLabel?.text = reportSenderArray[indexPath.row]
        cell.selectionNameLabel?.text = self.getReporterNameFromEmployeeID(employeeID: reportSenderArray[indexPath.row])
        if reportSenderArray[indexPath.row] == selectedPeopleArray[indexPath.row]
        {
            cell.selectionButton.setImage(UIImage.init(named: "selected"), for: UIControlState.normal)
        }
        else
        {
            cell.selectionButton.setImage(UIImage.init(named: "unselected"), for: UIControlState.normal)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if selectedPeopleArray.contains(reportSenderArray[indexPath.row])
        {
            selectedPeopleArray[indexPath.row] = ""
        }
        else
        {
            selectedPeopleArray[indexPath.row] = reportSenderArray[indexPath.row]
        }
        
        tableView.reloadData()
    }
    
    // MARK: - Private
    
    func configureSelectedPeopleArrayWithEmptyObjects()
    {
        for _ in 0...self.reportSenderDetailArray.count-1
        {
            self.selectedPeopleArray.append("")
        }
    }
    
    func configureSelectedPeopleArrayForSelectedContacts() -> [NSMutableDictionary]
    {
        self.reportSenderArrayNew = [NSMutableDictionary]()
        for i in 0...self.selectedPeopleArray.count-1
        {
            
            let employeeID = self.selectedPeopleArray[i]
            if employeeID == ""
            {}
            else
            {
                for j in 0...self.reportSenderDetailArray.count-1
                {
                    var item = NSDictionary()
                    item = self.reportSenderDetailArray[j] as! NSDictionary
                    let employeeId = item["employeeId"] as! Int
                    
                    if String(employeeId) == employeeID
                    {
                        let employeeName = item["employeeFullName"]
                        let reporterDict = NSMutableDictionary.init()
                        reporterDict.setValue(employeeName, forKey: "employeeFullName")
                        reporterDict.setValue(employeeId, forKey: "employeeId")
                        self.reportSenderArrayNew.append(reporterDict)
                        
                    }
                }
            }
        }
        
        return self.reportSenderArrayNew
    }
    
    
    
    func getReporterNameFromEmployeeID(employeeID:String) -> String
    {
        self.reportSenderArrayNew = [NSMutableDictionary]()
        
        for i in 0...self.reportSenderDetailArray.count-1
        {
            var item = NSDictionary()
            item = self.reportSenderDetailArray[i] as! NSDictionary
            let employeeId = item["employeeId"] as! Int
            if String(employeeId) == employeeID
            {
                let employeeName = item["employeeFullName"]
                
                let reporterDict = NSMutableDictionary.init()
                reporterDict.setValue(employeeName, forKey: "employeeFullName")
                reporterDict.setValue(employeeId, forKey: "employeeId")
                self.reportSenderArrayNew.append(reporterDict)
                
                return employeeName as! String
            }
        }
        return ""
    }
    
    // MARK: - APIs
    
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
                
                let alertController = UIAlertController(title: "Sharing Report", message: "You have successfully Shared the report", preferredStyle: .alert)
                let alertActionCancel = UIAlertAction(title: "OK", style: .cancel)
                { (action) in
                    
                    self.presentingViewController?.presentingViewController?.dismiss(animated: true)
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
                        PSUserInterfaceManager.showAlert(title: "Sharing Reports", message: ApiResultFailureMessage.InvalidEmailPassword)
                    }
                    else
                    {
                        
                    }
                    
            }, errorPopup: true)
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

protocol PSSelectDialogViewControllerDelegate
{
    func reportSendersSelected(senders: [NSMutableDictionary])
}
