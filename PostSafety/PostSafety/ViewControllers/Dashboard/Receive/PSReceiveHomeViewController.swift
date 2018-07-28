//
//  PSReceiveHomeViewController.swift
//  PostSafety
//
//  Created by Rayyan on 24/06/2018.
//  Copyright © 2018 Now Tel. All rights reserved.
//

import UIKit

class PSReceiveHomeViewController: UIViewController
{

    @IBOutlet weak var view5: UIView!
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view1: UIView!
    
    @IBOutlet weak var summaryStatisticsStackView: UIStackView!
    
    var cheklistArray = [Any]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if PSDataManager.sharedInstance.loggedInUser?.employeeType == "Reviewers"
        {
            self.summaryStatisticsStackView.isHidden = false
        }
        else
        {
            self.summaryStatisticsStackView.isHidden = true
        }
        
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

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - IBActions
    
    @IBAction func alertsGestureTapped(_ sender: Any)
    {
        let storyboard = UIStoryboard(name: "User", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PSReceiveAlertsViewController") as! PSReceiveAlertsViewController
        navigationController?.pushViewController(vc,
                                                 animated: true)
    }
    @IBAction func viewReportsGestureTapped(_ sender: Any)
    {
        let storyboard = UIStoryboard(name: "User", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PSFeedViewController") as! PSFeedViewController
        vc.feedTitle = "Reports"
        vc.route = Route.AllReports.rawValue
        navigationController?.pushViewController(vc,
                                                 animated: true)
    }
    @IBAction func trainingGestureTapped(_ sender: Any)
    {
        let storyboard = UIStoryboard(name: "User", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PSFeedViewController") as! PSFeedViewController
        vc.feedTitle = "Training"
        vc.route = Route.Trainings.rawValue
        navigationController?.pushViewController(vc,
                                                 animated: true)
    }
    @IBAction func policiesGestureTapped(_ sender: Any)
    {
        let storyboard = UIStoryboard(name: "User", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PSFeedViewController") as! PSFeedViewController
        vc.feedTitle = "Policies/Procedures"
        vc.route = Route.PolicyProcedures.rawValue
        navigationController?.pushViewController(vc,
                                                 animated: true)
    }
    
    
    @IBAction func backButtonTouched(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
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
