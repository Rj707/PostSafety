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
        
        self.configureAndInitialize()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configureAndInitialize()
    {
        definitionsTableView.delegate = self
        definitionsTableView.dataSource = self
        definitionsTableView.alwaysBounceVertical = false
        
        definitionsArray.append(String(format: "%@\r%@", "A hazard is the potential for harm or an adverse effect (for example, to people as health effects, to organizations as property or equipment losses, or to the environment). Workplace hazards can come from a wide range of sources.","General examples include any substance, material, process, practice, etc. that has the ability to cause harm or adverse health effect to a person or property."))
        definitionsArray.append("A subset of incidents that could have resulted in injury, illness or property damage, if given a different set of circumstances, but didn't. Near misses are also known as 'close calls.' Perhaps the better term to consider is 'near hit.'")
        definitionsArray.append("An unplanned, undesired event that hinders completion of a task and may cause injury, illness, or property damage or some combination of all three in varying degrees from minor to catastrophic. Unplanned and undesired do not mean unable to prevent. Unplanned and undesired also do not mean unable to prepare for Crisis planning is how we prepare for serious incidents that occur that require response for mitigation.")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.definitionsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var cell:PSFeedTableViewCell
        cell = tableView.dequeueReusableCell(withIdentifier: "DefinitionsCell") as! PSFeedTableViewCell
        switch indexPath.row
        {
            case 0:
                cell.titleLabel.text = "Hazard"
                break
            case 1:
                cell.titleLabel.text = "Near Miss"
                break
            default:
                cell.titleLabel.text = "Incident"
                break
        }
        cell.detailLabel.text = self.definitionsArray[indexPath.row] as? String
        return cell
    }
    
    // MARK: - IBActions
    
    @IBAction func backButtonTouched(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
        
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
