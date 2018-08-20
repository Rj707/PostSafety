//
//  PSDefinitionViewController.swift
//  PostSafety
//
//  Created by Hafiz Saad on 20/08/2018.
//  Copyright © 2018 Now Tel. All rights reserved.
//

import UIKit

class PSDefinitionViewController: UIViewController,UITableViewDelegate,UITableViewDataSource
{

    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var definitionsTableView: UITableView!
    var definitionsArray = [Any]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.addMenuAction()
        
        definitionsTableView.delegate = self
        definitionsTableView.dataSource = self
        definitionsTableView.alwaysBounceVertical = false
        
        definitionsArray.append("- The inputs should show which options should be selected. So this screen should show ‘Open’ for post status, ‘All’ for Type, Location and Sender, and nothing for the dates.")
        definitionsArray.append("-I also noticed that the filters require the user to select a start and end date. Please disable that requirement.")
        definitionsArray.append("- With the above changes in mind, please check that the sort posts functionality is working correctly.")
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func addMenuAction()
    {
        if self.revealViewController() != nil
        {
            menuButton.addTarget(self.revealViewController(), action: #selector(self.revealViewController().revealToggle(_:)), for: .touchUpInside)
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
            let menuVC = revealViewController().rearViewController as? MenuViewController
            
            menuVC?.dashboardNavViewController = self.navigationController
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.definitionsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var cell:PSFeedTableViewCell
        cell = tableView.dequeueReusableCell(withIdentifier: "DefinitionsCell") as! PSFeedTableViewCell
//        let dic = self.definitionsArray[indexPath.row] as! NSDictionary
//        cell.categoryTitleLabel.text = dic["name"] as? String
//        cell.data = self.definitionsArray[indexPath.row] as! NSDictionary
        cell.titleLabel.text = self.definitionsArray[indexPath.row] as? String
        return cell
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
