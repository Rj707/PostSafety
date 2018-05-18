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

class UpdatesAnnouncementsViewController: UIViewController,UITableViewDataSource,UITableViewDelegate
{

    @IBOutlet weak var updatesAnnouncementsTableView : UITableView!
    var type : FeedType!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.type = FeedType.init(rawValue: 0)
        self.updatesAnnouncementsTableView.dataSource = self
        self.updatesAnnouncementsTableView.delegate = self
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var cell:UITableViewCell
        if self.type.rawValue == 0
        {
            cell = tableView.dequeueReusableCell(withIdentifier: "AnnouncementCell", for: indexPath)
        }
        else
        {
            cell = tableView.dequeueReusableCell(withIdentifier: "SharedReportsCell", for: indexPath)
        }
        
        return cell
    }
    
    // MARK: - IBActions
    
    @IBAction func backButtonTouched(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func announcementsViewTouched(_ sender: UITapGestureRecognizer)
    {
        self.type = FeedType(rawValue: 0)
        self.updatesAnnouncementsTableView.reloadData()
    }
    
    @IBAction func sharedReportsViewTouched(_ sender: UITapGestureRecognizer)
    {
        self.type = FeedType(rawValue: 1)
        self.updatesAnnouncementsTableView.reloadData()
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
