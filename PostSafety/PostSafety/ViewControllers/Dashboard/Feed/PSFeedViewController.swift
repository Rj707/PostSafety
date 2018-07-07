//
//  UpdatesAnnouncementsViewController.swift
//  PostSafety
//
//  Created by Hafiz Saad on 16/05/2018.
//  Copyright © 2018 Now Tel. All rights reserved.
//

enum FeedType :Int
{
    case Announcement
    case SharedReports
}

import UIKit

class PSFeedViewController: UIViewController,UITableViewDataSource,UITableViewDelegate

{
    @IBOutlet weak var unOpenedView: UIView!
    @IBOutlet weak var archivedView: UIView!
    
    @IBOutlet weak var sharedReportsView: UIView!
    @IBOutlet weak var myReportsView: UIView!
    @IBOutlet weak var allReportsView: UIView!
    
    @IBOutlet weak var filterReportsView: UIView!
    @IBOutlet weak var reportsStackView: UIStackView!
    
    @IBOutlet weak var updatesAnnouncementsTableView : UITableView!
    @IBOutlet weak var feedTitleLabel: UILabel!
    
    var feedTitle: String = ""
    
    var type : FeedType!
    var feedArray = [Any]()
    var feedArray2 = Array<Any>()
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.updatesAnnouncementsTableView.tableFooterView = UIView.init()
        
        self.type = FeedType.init(rawValue: 0)
        self.updatesAnnouncementsTableView.dataSource = self
        self.updatesAnnouncementsTableView.delegate = self
        self.feedTitleLabel.text = self.feedTitle
        
        if Global.USERTYPE?.rawValue == UserType.UserTypeAdmin.rawValue && feedTitle == "Reports"
        {
            self.filterReportsView.isHidden = false
            self.reportsStackView.isHidden = false
        }
        else
        {
            self.filterReportsView.isHidden = true
            self.reportsStackView.isHidden = true
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.feedArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var cell:PSFeedTableViewCell
        if self.type.rawValue == 0
        {
            cell = tableView.dequeueReusableCell(withIdentifier: "AnnouncementCell", for: indexPath) as! PSFeedTableViewCell
        }
        else
        {
            cell = tableView.dequeueReusableCell(withIdentifier: "SharedReportsCell", for: indexPath) as! PSFeedTableViewCell
        }
        let dic = self.feedArray[indexPath.row] as! NSDictionary
        cell.titleLabel.text = dic["title"] as? String
//        cell.titleLabel.text = (self.feedArray[indexPath.row])[""]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let dic = self.feedArray[indexPath.row] as! NSDictionary
        
        if Global.USERTYPE?.rawValue == UserType.UserTypeAdmin.rawValue && feedTitle == "Reports"
        {
            let storyboard = UIStoryboard(name: "User", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "PSReportPostViewController") as! PSReportPostViewController
            navigationController?.pushViewController(vc,
                                                     animated: true)
        }
        else if Global.USERTYPE?.rawValue == UserType.UserTypeNormal.rawValue && feedTitle == "Reports"
        {
            let storyboard = UIStoryboard(name: "User", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "PSReportPostViewController") as! PSReportPostViewController
            navigationController?.pushViewController(vc,
                                                     animated: true)
        }
        else
        {
            let storyboard = UIStoryboard(name: "User", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "PSFeedDetailViewController") as! PSFeedDetailViewController
//            vc.feedDetailTitle = self.feedTitleLabel.text!
            vc.feedDetailTitle = (dic["title"] as? String)!
            vc.feedDict = dic
            navigationController?.pushViewController(vc,
                                                     animated: true)
        }
        
    }
    
    // MARK: - IBActions
    
    @IBAction func backButtonTouched(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func announcementsViewTouched(_ sender: UITapGestureRecognizer)
    {
//        self.announcementView.backgroundColor=UIColor.init(red: 255/255.0, green: 37/255.0, blue: 1/255.0, alpha: 1.0)
//        
//        self.type = FeedType(rawValue: 0)
        self.updatesAnnouncementsTableView.reloadData()
    }
    
    @IBAction func sharedReportsViewTouched(_ sender: UITapGestureRecognizer)
    {
//    self.sharedreportView.backgroundColor=UIColor.init(red: 255/255.0, green: 37/255.0, blue: 1/255.0, alpha: 1.0)
//        self.type = FeedType(rawValue: 1)
        self.updatesAnnouncementsTableView.reloadData()
    }
    
    @IBAction func filterReportsGestureTouched(sender: UITapGestureRecognizer)
    {
        self.definesPresentationContext = true;
        let termsOfUseVC : PSSortReportsDialogViewController
        let storyBoard = UIStoryboard.init(name: "Admin", bundle: Bundle.main)
        termsOfUseVC = storyBoard.instantiateViewController(withIdentifier: "PSSortReportsDialogViewController") as! PSSortReportsDialogViewController
        termsOfUseVC.view.backgroundColor = UIColor.clear
        termsOfUseVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        //        self.view.backgroundColor = UIColor.clear
        //        self.modalPresentationStyle = UIModalPresentationStyle.currentContext
        self.present(termsOfUseVC, animated: true)
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
