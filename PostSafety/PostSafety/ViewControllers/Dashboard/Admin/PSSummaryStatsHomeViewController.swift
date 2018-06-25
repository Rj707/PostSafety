//
//  SummaryStatsHomeViewController.swift
//  PostSafety
//
//  Created by Pasha on 24/06/2018.
//  Copyright © 2018 Now Tel. All rights reserved.
//

import UIKit

class PSSummaryStatsHomeViewController: UIViewController {

    @IBOutlet weak var yesterdayView: UIView!
    @IBOutlet weak var monthView: UIView!
    @IBOutlet weak var yearView: UIView!
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.yesterdayView.layer.borderWidth=2
        self.monthView.layer.borderWidth=2
        self.yearView.layer.borderWidth=2
      
        self.yesterdayView.layer.borderColor = UIColor(red:255/255, green:75/255, blue:1/255, alpha: 1).cgColor
        self.monthView.layer.borderColor = UIColor(red:255/255, green:75/255, blue:1/255, alpha: 1).cgColor
        self.yearView.layer.borderColor = UIColor(red:255/255, green:75/255, blue:1/255, alpha: 1).cgColor
        
        self.view1.layer.borderWidth=2
        self.view2.layer.borderWidth=2
        self.view3.layer.borderWidth=2
        
        self.view1.layer.borderColor = UIColor(red:255/255, green:75/255, blue:1/255, alpha: 1).cgColor
        self.view2.layer.borderColor = UIColor(red:255/255, green:75/255, blue:1/255, alpha: 1).cgColor
        self.view3.layer.borderColor = UIColor(red:255/255, green:75/255, blue:1/255, alpha: 1).cgColor
        
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - IBActions
    
    @IBAction func yesterdayGestureTapped(_ sender: Any)
    {
        let storyboard = UIStoryboard(name: "Admin", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PSCategorySelectViewController") as! PSCategorySelectViewController
        vc.summaryStatisticsTitle = "Yesterday's "
        navigationController?.pushViewController(vc,
                                                 animated: true)
    }
    @IBAction func thisMonthGestureTapped(_ sender: Any)
    {
        let storyboard = UIStoryboard(name: "Admin", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PSCategorySelectViewController") as! PSCategorySelectViewController
        vc.summaryStatisticsTitle = "This Month's "
        navigationController?.pushViewController(vc,
                                                 animated: true)
    }
    @IBAction func yearToDateGestureTapped(_ sender: Any)
    {
        let storyboard = UIStoryboard(name: "Admin", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PSCategorySelectViewController") as! PSCategorySelectViewController
        vc.summaryStatisticsTitle = "Year To Date's "
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
