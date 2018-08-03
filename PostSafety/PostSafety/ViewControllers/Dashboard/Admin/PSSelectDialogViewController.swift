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
    
    @IBOutlet weak var selectDialogTableView:UITableView!
    @IBOutlet weak var selectionButton:UIButton!
    @IBOutlet weak var searchBar:UISearchBar!
    @IBOutlet weak var selectionLabel:UILabel!
    var reportSenderArray = [String]()
    var reportSenderDetailArray = [Any]()
    var selectedPeopleArray = [String]()
    var companyId = 0
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.selectDialogTableView.dataSource = self
        self.selectDialogTableView.delegate = self
        self.getAllEmployees()
        searchBar.backgroundColor = UIColor.clear
        searchBar.backgroundImage = UIImage()
        searchBar.isTranslucent = true

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
                        let name = item["employeeFullName"]
                        self.reportSenderArray.append(name as! String)
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
//        if selectionButton.titleLabel?.text == "  Select All"
        {
            self.selectionLabel.text = "Unselect All"
            selectedPeopleArray = self.reportSenderArray
            self.selectionButton.setImage(UIImage.init(named: "selected"), for: UIControlState.normal)
//            self.selectionButton.setTitle("  Unselect All", for: UIControlState.normal)
        }
        else
        {
            self.selectionLabel.text = "Select All"
            selectedPeopleArray = [String]()
            self.configureSelectPeopleArray()
            self.selectionButton.setImage(UIImage.init(named: "unselected"), for: UIControlState.normal)
//            self.selectionButton.setTitle("  Select All", for: UIControlState.normal)
        }
        
        selectDialogTableView.reloadData()
    }
    
    @IBAction func crossButtonTouched(_ sender: UIButton)
    {
        self.dismiss(animated: true)
        {
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
    
    func configureSelectPeopleArray()
    {
        for _ in 0...self.reportSenderDetailArray.count-1
        {
            self.selectedPeopleArray.append("")
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
