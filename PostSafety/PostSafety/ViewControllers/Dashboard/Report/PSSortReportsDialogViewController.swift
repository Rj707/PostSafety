//
//  PSSortReportsDialogViewController.swift
//  PostSafety
//
//  Created by Rayyan on 25/06/2018.
//  Copyright © 2018 Now Tel. All rights reserved.
//

import UIKit

class PSSortReportsDialogViewController: UIViewController,IQDropDownTextFieldDelegate,IQDropDownTextFieldDataSource
{
    public var delegate:PSSortReportsDialogViewControllerDelegate!
    
    @IBOutlet weak var view5: UIView!
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view0: UIView!
    
    @IBOutlet weak var reportStatusDDTextField: IQDropDownTextField!
    @IBOutlet weak var reportLocationDDTextField: IQDropDownTextField!
    @IBOutlet weak var reportSenderDDTextField: IQDropDownTextField!
    @IBOutlet weak var reportTypeDDTextField: IQDropDownTextField!
    @IBOutlet weak var reportStartDateDDTextField: UITextField!
    @IBOutlet weak var reportEndDateDDTextField: UITextField!
    
    var datePickerStart : UIDatePicker!
    var datePickerEnd : UIDatePicker!
    
    var reportLocationArray = [Any]()
    var reportLocationAddressArray = [Any]()
    var reportSenderArray = [String]()
    var reportTypeArray = ["Hazard", "Near Miss", "Incident","Emergency"]
    var reportStatusArray = ["Open Posts", "Closed Posts", "All Posts"]
    var reportSenderDetailArray = [Any]()

    var companyId = 0
    var cheklistArray = [Any]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.getAllEmployees()
        self.getLocationsforReport()
        
        reportLocationDDTextField.dataSource = self
        reportLocationDDTextField.delegate = self
        reportTypeDDTextField.dataSource = self
        reportTypeDDTextField.delegate = self
        reportSenderDDTextField.dataSource = self
        reportSenderDDTextField.delegate = self
        
        reportLocationDDTextField.isOptionalDropDown = false
        reportSenderDDTextField.isOptionalDropDown = false
        reportTypeDDTextField.isOptionalDropDown = false
        reportStatusDDTextField.isOptionalDropDown = false
        
        reportTypeDDTextField.itemList = reportTypeArray
        reportStatusDDTextField.itemList = reportStatusArray
        
        self.view1.layer.borderWidth = 1
        self.view2.layer.borderWidth = 1
        self.view3.layer.borderWidth = 1
        self.view4.layer.borderWidth = 1
        self.view5.layer.borderWidth = 1
        self.view0.layer.borderWidth = 1
        self.view0.layer.borderColor = UIColor(red:255/255, green:75/255, blue:1/255, alpha: 1).cgColor
        self.view5.layer.borderColor = UIColor(red:255/255, green:75/255, blue:1/255, alpha: 1).cgColor
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
    
    
    
    // MARK: - IBActions
    
    @IBAction func crossButtonTouched(_ sender: UIButton)
    {
        self.dismiss(animated: true)
        {
        }
    }
    
    @IBAction func applyFiltersButtonTouched(_ sender: UIButton)
    {
        let filterDictionary = NSMutableDictionary.init()
         if self.reportStatusDDTextField.selectedItem == ""
        {
            PSUserInterfaceManager.showAlert(title: "Apply Filters", message: "Select Post Status")
        }
        else if self.reportTypeDDTextField.selectedItem == ""
        {
            PSUserInterfaceManager.showAlert(title: "Apply Filters", message: "Select Post type")
        }
        else if self.reportLocationDDTextField.selectedItem == ""
        {
            PSUserInterfaceManager.showAlert(title: "Apply Filters", message: "Select Post Location")
        }
        else if self.reportSenderDDTextField.selectedItem == ""
        {
            PSUserInterfaceManager.showAlert(title: "Apply Filters", message: "Select Post Sender")
        }
        else if self.reportStartDateDDTextField.text == ""
        {
            PSUserInterfaceManager.showAlert(title: "Apply Filters", message: "Select Post Start Date")
        }
        else if self.reportEndDateDDTextField.text == ""
        {
            PSUserInterfaceManager.showAlert(title: "Apply Filters", message: "Select Post End Date")
        }
        else
        {
            print(self.reportTypeDDTextField.selectedItem ?? "")
            print(self.reportSenderDDTextField.selectedItem ?? "")
            print(self.reportStartDateDDTextField.text ?? "")
            print(self.reportEndDateDDTextField.text ?? "")
            
            
            filterDictionary["ReportType"] = self.reportTypeDDTextField.selectedItem
            
            filterDictionary.setValue(self.reportTypeDDTextField.selectedItem, forKey: "ReportType")
            filterDictionary.setValue(self.reportSenderDDTextField.selectedItem, forKey: "ReportedBy")
            filterDictionary.setValue(self.reportStartDateDDTextField.text, forKey: "startdate")
            filterDictionary.setValue(self.reportEndDateDDTextField.text, forKey: "enddate")
            if self.reportStatusDDTextField.selectedItem == "Open Posts"
            {
                filterDictionary.setValue(NSNumber.init(value: true), forKey: "Status")
            }
            else if self.reportStatusDDTextField.selectedItem == "Closed Posts"
            {
                filterDictionary.setValue(NSNumber.init(value: false), forKey: "Status")
            }
            else
            {
                filterDictionary.setValue("", forKey: "Status")
            }
            
            filterDictionary.setValue(String(self.branchIdForSelctedRow(row: self.reportLocationDDTextField.selectedRow)), forKey: "branchId")
            self.delegate.applyFilters(filterData: filterDictionary)
            self.dismiss(animated: true)
            {
                
            }
        }
    }
    
    // MARK: - UITapGestureRecognizer
    
    @IBAction func selectStartDate(_ sender: UITapGestureRecognizer)
    {
        let alertController = UIAlertController(title: "\n\n\n\n\n\n\n\n\n\n\n", message: nil, preferredStyle: .actionSheet)
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        alertController.view.addSubview(picker)
        let alertActionCancel = UIAlertAction(title: "Cancel", style: .cancel)
        { (action) in
            
        }
        let alertActionOK = UIAlertAction(title: "OK", style: .default)
        { (action) in
            
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "yyyy-MM-dd"
            dateFormatterGet.timeZone = TimeZone.current
            
            self.reportStartDateDDTextField.text = dateFormatterGet.string(from: picker.date)
            alertController.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(alertActionCancel)
        alertController.addAction(alertActionOK)
        
        let popoverController: UIPopoverPresentationController? = alertController.popoverPresentationController
        popoverController?.sourceView = sender.view
        popoverController?.sourceRect = (sender.view?.frame)!
        present(alertController, animated: true)
    }
    
    @IBAction func selectEndDate(_ sender: UITapGestureRecognizer)
    {
        let alertController = UIAlertController(title: "\n\n\n\n\n\n\n\n\n\n\n", message: nil, preferredStyle: .actionSheet)
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        
        alertController.view.addSubview(picker)
        let alertActionCancel = UIAlertAction(title: "Cancel", style: .cancel)
        { (action) in
            
        }
        let alertActionOK = UIAlertAction(title: "OK", style: .default)
        { (action) in
            
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "yyyy-MM-dd"
            dateFormatterGet.timeZone = TimeZone.current
    
            self.reportEndDateDDTextField.text = dateFormatterGet.string(from: picker.date)
            alertController.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(alertActionCancel)
        alertController.addAction(alertActionOK)
        
        let popoverController: UIPopoverPresentationController? = alertController.popoverPresentationController
        popoverController?.sourceView = sender.view
        popoverController?.sourceRect = (sender.view?.frame)!
        present(alertController, animated: true)
    }
    
    // MARK: - APIs
    
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
                        let name = item["employeeFullName"]
                        self.reportSenderArray.append(name as! String)
                    }
                    
                    self.reportSenderDDTextField.itemList = self.reportSenderArray
                    print(self.reportSenderDetailArray)
                    
            }, failure:
                { (error:NSError,statusCode:Int) in
                    
                    PSUserInterfaceManager.sharedInstance.hideLoader()
                    if(statusCode==404)
                    {
                        PSUserInterfaceManager.showAlert(title: "Senders", message: ApiErrorMessage.ErrorOccured)
                    }
                    else
                    {
                        
                    }
                    
            }, errorPopup: true)
        }
    }
    
    func getLocationsforReport() -> Void
    {
        if CEReachabilityManager.isReachable()
        {
            PSUserInterfaceManager.sharedInstance.showLoaderWithText(text: "Fetching Locations")
            companyId = (PSDataManager.sharedInstance.loggedInUser?.companyId)!
            PSAPIManager.sharedInstance.getLocationsFor(companyId: String(companyId) ,success:
            { (dic) in
                PSUserInterfaceManager.sharedInstance.hideLoader()
                let tempArray = dic["array"] as! [Any]
                
                for checklistDict in tempArray
                {
                    if let tempDict = checklistDict as? [String: Any]
                    {
                        self.reportLocationArray.append(tempDict)
                    }
                }
                
                for i in 0...self.reportLocationArray.count-1
                {
                    var tempDict = self.reportLocationArray[i] as? [String: Any]
                    self.reportLocationAddressArray.append(tempDict!["branchName"] ?? "No Branch Address")
                }
               
                
                self.reportLocationDDTextField.itemList = self.reportLocationAddressArray as? [String]
                    
            }, failure:
                
                {
                    (error:NSError,statusCode:Int) in
                    PSUserInterfaceManager.sharedInstance.hideLoader()
                    if(statusCode==404)
                    {
                        PSUserInterfaceManager.showAlert(title: "Locations", message: ApiErrorMessage.ErrorOccured)
                    }
                    else
                    {
                        
                    }
                    
            }, errorPopup: true)
        }
    }
    
    func branchIdForSelctedRow(row: Int)-> Int
    {
        var tempDict = self.reportLocationArray[row] as! [String:Any]
        return tempDict["branchId"] as! Int
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

protocol PSSortReportsDialogViewControllerDelegate
{
    func applyFilters(filterData: NSMutableDictionary)
}
