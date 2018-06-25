//
//  CategorySelectViewController.swift
//  PostSafety
//
//  Created by Pasha on 24/06/2018.
//  Copyright © 2018 Now Tel. All rights reserved.
//

import UIKit

class PSCategorySelectViewController: UIViewController {

    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    
    var summaryStatisticsTitle: String = ""
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.view1.layer.borderWidth=2
        self.view2.layer.borderWidth=2
        self.view3.layer.borderWidth=2
        self.view4.layer.borderWidth=2
        
        self.view4.layer.borderColor = UIColor(red:255/255, green:75/255, blue:1/255, alpha: 1).cgColor
        self.view1.layer.borderColor = UIColor(red:255/255, green:75/255, blue:1/255, alpha: 1).cgColor
        self.view2.layer.borderColor = UIColor(red:255/255, green:75/255, blue:1/255, alpha: 1).cgColor
        self.view3.layer.borderColor = UIColor(red:255/255, green:75/255, blue:1/255, alpha: 1).cgColor
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - IBActions
    
    @IBAction func backButtonTouched(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func hazardGestureTapped(_ sender: Any)
    {
        let storyboard = UIStoryboard(name: "Admin", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PSSummaryFeedViewController") as! PSSummaryFeedViewController
        summaryStatisticsTitle += "Hazard"
        vc.summaryFeedTitle += summaryStatisticsTitle
        navigationController?.pushViewController(vc,
                                                 animated: true)
    }
    @IBAction func nearMissGestureTapped(_ sender: Any)
    {
        let storyboard = UIStoryboard(name: "Admin", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PSSummaryFeedViewController") as! PSSummaryFeedViewController
        summaryStatisticsTitle += "Near Miss"
        vc.summaryFeedTitle += summaryStatisticsTitle
        navigationController?.pushViewController(vc,
                                                 animated: true)
    }
    @IBAction func incidentGestureTapped(_ sender: Any)
    {
        let storyboard = UIStoryboard(name: "Admin", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PSSummaryFeedViewController") as! PSSummaryFeedViewController
        summaryStatisticsTitle += "Incident"
        vc.summaryFeedTitle += summaryStatisticsTitle
        navigationController?.pushViewController(vc,
                                                 animated: true)
    }
    @IBAction func emergencyTapped(_ sender: Any)
    {
        let storyboard = UIStoryboard(name: "Admin", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PSSummaryFeedViewController") as! PSSummaryFeedViewController
        summaryStatisticsTitle += "Emergency"
        vc.summaryFeedTitle += summaryStatisticsTitle
        navigationController?.pushViewController(vc,
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
