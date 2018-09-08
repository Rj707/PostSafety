//
//  SelectCategoryViewController.swift
//  PostSafety
//
//  Created by Pasha on 18/05/2018.
//  Copyright © 2018 Now Tel. All rights reserved.
//

import UIKit

class PSSelectCategoryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource
{
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var categoryTableView: UITableView!
    @IBOutlet weak var pageControl : UIPageControl!
    
    var nextViewController : UIViewController!
    var cheklistDetailsArray = [Any]()
    var checklistId = 0
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if PSDataManager.sharedInstance.report?.reportType == "Hazard" || PSDataManager.sharedInstance.report?.reportType == "Incident"
        {
            pageControl.numberOfPages = 2
            pageControl.currentPage = 0
        }
        else if PSDataManager.sharedInstance.report?.reportType == "NearMiss"
        {
            pageControl.numberOfPages = 3
            pageControl.currentPage = 0
        }
        
        self.categoryTableView.dataSource = self
        self.categoryTableView.delegate = self
        PSDataManager.sharedInstance.report?.categoryID = self.checklistId
        self.backgroundView.layer.borderWidth=1
        self.backgroundView.layer.borderColor = UIColor(red:255/255, green:75/255, blue:1/255, alpha: 1).cgColor
        
        self.setNextViewController()
//        self.configureCategoryForReportType()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setNextViewController()
    {
        let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
        
        switch PSDataManager.sharedInstance.report?.reportType
        {
        case "Hazard":
            nextViewController = storyboard.instantiateViewController(withIdentifier: "PSSelectLocationViewController") as! PSSelectLocationViewController
        case "Incident":
            nextViewController = storyboard.instantiateViewController(withIdentifier: "PSSelectLocationViewController") as! PSSelectLocationViewController
        case "NearMiss":
            nextViewController = storyboard.instantiateViewController(withIdentifier: "PSSelectSubCategoryViewController") as! PSSelectSubCategoryViewController
        default:
            print("")
        }
    }
    
    func getCheckListDetails()
    {
        PSAPIManager.sharedInstance.checklistManagerAPI.getChecklistDetailsWith(checkListID: String(checklistId),
                                                                                success:
            { (dic:Dictionary<String,Any>) in
                
                let tempArray = dic["array"] as! [Any]
                
                for checklistDetailDict in tempArray
                {
                    //                            if let dict = peopleDict as? [String: Any], let peopleArray = dict["People"] as? [String]
                    if let tempDict = checklistDetailDict as? [String: Any]
                    {
                        var checklistDetail = PSChecklistDetail()
                        checklistDetail = checklistDetail.initWithDictionary(dict: tempDict as NSDictionary)
                        self.cheklistDetailsArray.append(checklistDetail)
                    }
                }
                print(self.cheklistDetailsArray)
        },
                                                                                failure:
            { (error, statusCode) in
                
        }, errorPopup: true)
    }
    
//    func configureCategoryForReportType() -> Void
//    {
//        for i in 0...self.cheklistDetailsArray.count-1
//        {
//            var item = NSDictionary()
//            item = cheklistDetailsArray[i] as! NSDictionary
//
//            switch i
//            {
//            case 0  :
//                self.label1.text = item["name"] as? String
//            case 1  :
//                self.label2.text = item["name"] as? String
//            case 2  :
//                self.label3.text = item["name"] as? String
//            default :
//                self.label4.text = item["name"] as? String
//            }
//        }
//    }
    
    // MARK: - IBActions
    
    @IBAction func backButtonTouched(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.cheklistDetailsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var cell:PSCategoryTableViewCell
        cell = tableView.dequeueReusableCell(withIdentifier: "PSCategoryTableViewCell") as! PSCategoryTableViewCell
        let dic = self.cheklistDetailsArray[indexPath.row] as! NSDictionary
        cell.categoryTitleLabel.text = dic["name"] as? String
        cell.data = self.cheklistDetailsArray[indexPath.row] as! NSDictionary
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        self.setNextViewController()
        var cell:PSCategoryTableViewCell
        cell = tableView.cellForRow(at: indexPath) as! PSCategoryTableViewCell
        PSDataManager.sharedInstance.report?.reportCategory = cell.data["name"] as? String
        
        if PSDataManager.sharedInstance.report?.reportType == "NearMiss"
        {
            let vc =   nextViewController as! PSSelectSubCategoryViewController
            vc.CatagoryID = (cell.data["checklistDetailsId"] as? Int)!
        }
        
        // TODO: Offline Post Submisison
        PSDataManager.sharedInstance.offlinePostDictionary.setValue(cell.data["checklistDetailsId"] as? Int, forKey: "CatagoryId")
        
        PSDataManager.sharedInstance.report?.categoryID = (cell.data["checklistDetailsId"] as? Int)!
        navigationController?.pushViewController(nextViewController,
                                                 animated: true)
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
