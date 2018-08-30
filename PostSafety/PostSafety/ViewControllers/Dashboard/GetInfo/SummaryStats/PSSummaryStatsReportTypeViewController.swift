//
//  CategorySelectViewController.swift
//  PostSafety
//
//  Created by Pasha on 24/06/2018.
//  Copyright © 2018 Now Tel. All rights reserved.
//

import UIKit

class PSSummaryStatsReportTypeViewController: UIViewController
{

    @IBOutlet weak var menuButton:UIButton!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    
    @IBOutlet weak var hazardLabel: UILabel!
    @IBOutlet weak var nearMissLabel: UILabel!
    @IBOutlet weak var incidentLabel: UILabel!
    @IBOutlet weak var emergencyLabel: UILabel!
    
    var summaryStatisticsTitle: String = ""
    var summaryStatisticsTitleStatic: String = ""
    var DateType: String = ""
    
    
    var summaryStatisticsDict = NSDictionary.init()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.addMenuAction()
        self.summaryStatisticsTitleStatic = self.summaryStatisticsTitle
        self.hazardLabel.text =  String(format: "%@%@%@%@", "Hazards ","(", String(summaryStatisticsDict["numberOfHazards"] as! Int),")")
        self.nearMissLabel.text = String(format: "%@%@%@%@", "NearMisses  ","(", String(summaryStatisticsDict["numberOfNearMisses"] as! Int),")")
        self.incidentLabel.text = String(format: "%@%@%@%@", "Incidents ","(", String(summaryStatisticsDict["numberOfIncidents"] as! Int),")")
        self.emergencyLabel.text = String(format: "%@%@%@%@", "Emergencies ","(", String(summaryStatisticsDict["numberOfEmergencies"] as! Int),")")
        
        self.view1.layer.borderWidth=1
        self.view2.layer.borderWidth=1
        self.view3.layer.borderWidth=1
        self.view4.layer.borderWidth=1
        
        self.view4.layer.borderColor = UIColor(red:255/255, green:75/255, blue:1/255, alpha: 1).cgColor
        self.view1.layer.borderColor = UIColor(red:255/255, green:75/255, blue:1/255, alpha: 1).cgColor
        self.view2.layer.borderColor = UIColor(red:255/255, green:75/255, blue:1/255, alpha: 1).cgColor
        self.view3.layer.borderColor = UIColor(red:255/255, green:75/255, blue:1/255, alpha: 1).cgColor
        
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        self.summaryStatisticsTitle = self.summaryStatisticsTitleStatic
    }
    
    // MARK: - IBActions
    
    @IBAction func backButtonTouched(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func hazardGestureTapped(_ sender: Any)
    {
        let storyboard = UIStoryboard(name: "Admin", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PSSummaryStatsFeedViewController") as! PSSummaryStatsFeedViewController
        summaryStatisticsTitle += "Hazards"
        vc.summaryFeedTitle += summaryStatisticsTitle
        vc.DateType = self.DateType
        vc.IncidentType = "Hazard"
        navigationController?.pushViewController(vc,
                                                 animated: true)
    }
    @IBAction func nearMissGestureTapped(_ sender: Any)
    {
        let storyboard = UIStoryboard(name: "Admin", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PSSummaryStatsFeedViewController") as! PSSummaryStatsFeedViewController
        summaryStatisticsTitle += "Near Misses"
        vc.summaryFeedTitle += summaryStatisticsTitle
        vc.DateType = self.DateType
        vc.IncidentType = "NearMiss"
        navigationController?.pushViewController(vc,
                                                 animated: true)
    }
    @IBAction func incidentGestureTapped(_ sender: Any)
    {
        let storyboard = UIStoryboard(name: "Admin", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PSSummaryStatsFeedViewController") as! PSSummaryStatsFeedViewController
        summaryStatisticsTitle += "Incidents"
        vc.summaryFeedTitle += summaryStatisticsTitle
        vc.DateType = self.DateType
        vc.IncidentType = "Incident"
        navigationController?.pushViewController(vc,
                                                 animated: true)
    }
    @IBAction func emergencyTapped(_ sender: Any)
    {
        let storyboard = UIStoryboard(name: "Admin", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PSSummaryStatsFeedViewController") as! PSSummaryStatsFeedViewController
        summaryStatisticsTitle += "Emergencies"
        vc.summaryFeedTitle += summaryStatisticsTitle
        vc.DateType = self.DateType
        vc.IncidentType = "Emergency"
        navigationController?.pushViewController(vc,
                                                 animated: true)
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
