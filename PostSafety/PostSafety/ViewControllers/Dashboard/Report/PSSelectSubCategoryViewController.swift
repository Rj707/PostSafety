//
//  PSSelectSubCategoryViewController.swift
//  PostSafety
//
//  Created by Hafiz Saad on 21/06/2018.
//  Copyright © 2018 Now Tel. All rights reserved.
//

import UIKit

class PSSelectSubCategoryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate
{

    @IBOutlet weak var backgroundView: UIView!
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    
    @IBOutlet weak var pageControl : UIPageControl!
    
    @IBOutlet weak var subCategoryTableView: UITableView!
    
    var subCategoriesArray = [Any]()
    var CatagoryID = 0
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        
         if PSDataManager.sharedInstance.report?.reportType == "Incident"
        {
            pageControl.numberOfPages = 3
            pageControl.currentPage = 1
        }
        
        self.getSubCategories()

        self.subCategoryTableView.dataSource = self as UITableViewDataSource
        self.subCategoryTableView.delegate = self as UITableViewDelegate
        
        self.backgroundView.layer.borderWidth=1
        self.backgroundView.layer.borderColor = UIColor(red:255/255, green:75/255, blue:1/255, alpha: 1).cgColor
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
        
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.subCategoriesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var cell:PSCategoryTableViewCell
        cell = tableView.dequeueReusableCell(withIdentifier: "PSCategoryTableViewCell") as! PSCategoryTableViewCell
        let dic = self.subCategoriesArray[indexPath.row] as! NSDictionary
        cell.categoryTitleLabel.text = dic["name"] as? String
        cell.data = self.subCategoriesArray[indexPath.row] as! NSDictionary
        //        cell.contentView.layer.borderWidth=1
        //        cell.contentView.layer.borderColor = UIColor(red:255/255, green:75/255, blue:1/255, alpha: 1).cgColor
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        var cell:PSCategoryTableViewCell
        cell = tableView.cellForRow(at: indexPath) as! PSCategoryTableViewCell
        PSDataManager.sharedInstance.report?.reportSubcategory = cell.data["name"] as? String
        
        self.performSegue(withIdentifier: "toReportLocationFromSubcategory", sender: (Any).self)
    }
    
    // MARK: - APIs
    
    func getSubCategories()
    {
        if CEReachabilityManager.isReachable()
        {
            PSUserInterfaceManager.sharedInstance.showLoaderWithText(text: "Fetching SubCategories")
            PSAPIManager.sharedInstance.checklistManagerAPI.getSubCategoriesWith(CatagoryID: String(CatagoryID),
                                                                                    success:
            { (dic:Dictionary<String,Any>) in
                
                PSUserInterfaceManager.sharedInstance.hideLoader()
                let tempArray = dic["array"] as! [Any]
                
                for checklistDetailDict in tempArray
                {
                    if let tempDict = checklistDetailDict as? [String: Any]
                    {
                        
                        self.subCategoriesArray.append(tempDict)
                    }
                }
                
                print(self.subCategoriesArray)
                self.subCategoryTableView.emptyDataSetSource = self as DZNEmptyDataSetSource
                self.subCategoryTableView.emptyDataSetDelegate = self as DZNEmptyDataSetDelegate
                self.subCategoryTableView.reloadData()
            },
                                                                                    failure:
            { (error, statusCode) in
                
                PSUserInterfaceManager.sharedInstance.hideLoader()
                if(statusCode==404)
                {
                    PSUserInterfaceManager.showAlert(title: "Fetching SubCategories", message: ApiErrorMessage.ErrorOccured)
                }
                else
                {
                    
                }
                
                
            }, errorPopup: true)
        }
    }
    
    //MARK: - DZNEmptyDataSetSource
    
    func image(forEmptyDataSet scrollView: UIScrollView?) -> UIImage?
    {
        return UIImage(named: "no_data")
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView?) -> NSAttributedString?
    {
        let myString = "No Data found!"
        //        let attributes = [NSFontAttributeName : UIFont.systemFont(ofSize: 19.0),NSForegroundColorAttributeName : UIColor(red: 255, green: 75, blue: 1, alpha: 1.0) ]
        let attributes = [NSFontAttributeName : UIFont.systemFont(ofSize: 19.0),NSForegroundColorAttributeName : UIColor.red ]
        let myAttrString = NSAttributedString(string: myString, attributes: attributes)
        return myAttrString
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
