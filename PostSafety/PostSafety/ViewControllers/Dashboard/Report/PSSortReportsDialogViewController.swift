//
//  PSSortReportsDialogViewController.swift
//  PostSafety
//
//  Created by Rayyan on 25/06/2018.
//  Copyright © 2018 Now Tel. All rights reserved.
//

import UIKit

class PSSortReportsDialogViewController: UIViewController
{

    @IBOutlet weak var view5: UIView!
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view1: UIView!
    
    @IBOutlet weak var reportCategoryDDTextField: IQDropDownTextField!
    @IBOutlet weak var reportSenderDDTextField: IQDropDownTextField!
    @IBOutlet weak var reportTypeDDTextField: IQDropDownTextField!
    @IBOutlet weak var reportStartDateDDTextField: UITextField!
    @IBOutlet weak var reportEndDateDDTextField: UITextField!
    
    var datePickerStart : UIDatePicker!
    var datePickerEnd : UIDatePicker!
    
    var reportCategoryArray = ["Category 1", "Category 2", "Category 3","Category 4"]
    var reportSenderArray = [String]()
    var reportTypeArray = ["Hazard", "Near Miss", "Incident","Emergency"]
    var reportSenderDetailArray = [Any]()

    var companyId = 0
    var cheklistArray = [Any]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.getAllEmployees()
        reportCategoryDDTextField.itemList = reportCategoryArray
        reportSenderDDTextField.itemList = reportSenderArray
        reportTypeDDTextField.itemList = reportTypeArray
        
        self.view1.layer.borderWidth=1
        self.view2.layer.borderWidth=1
        self.view3.layer.borderWidth=1
        self.view4.layer.borderWidth=1
        self.view5.layer.borderWidth=1
        self.view5.layer.borderColor = UIColor(red:255/255, green:75/255, blue:1/255, alpha: 1).cgColor
        self.view1.layer.borderColor = UIColor(red:255/255, green:75/255, blue:1/255, alpha: 1).cgColor
        self.view2.layer.borderColor = UIColor(red:255/255, green:75/255, blue:1/255, alpha: 1).cgColor
        self.view3.layer.borderColor = UIColor(red:255/255, green:75/255, blue:1/255, alpha: 1).cgColor
        self.view4.layer.borderColor = UIColor(red:255/255, green:75/255, blue:1/255, alpha: 1).cgColor
    }

    override func didReceiveMemoryWarning() {
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
    
    // MARK: - IBActions
    
    @IBAction func applyFiltersButtonTouched(_ sender: UIButton)
    {
        self.dismiss(animated: true)
        {
        }
    }
    
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
            dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
            
            self.reportStartDateDDTextField.text = dateFormatterGet.string(from: picker.date)
            alertController.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(alertActionCancel)
        alertController.addAction(alertActionOK)
        
//        alertController.addAction(UIAlertAction(title: "OK", style: .default)
//        { (action) in
//            alertController.dismiss(animated: true, completion: nil)
//        })
        
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
            dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
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
                        PSUserInterfaceManager.showAlert(title: "Senders", message: ApiResultFailureMessage.InvalidEmailPassword)
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
