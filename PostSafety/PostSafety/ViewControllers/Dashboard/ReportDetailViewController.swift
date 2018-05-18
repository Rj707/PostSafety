//
//  ReportDetailViewController.swift
//  PostSafety
//
//  Created by Pasha on 18/05/2018.
//  Copyright © 2018 Now Tel. All rights reserved.
//

import UIKit

class ReportDetailViewController: UIViewController {
    
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var sitelocationLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var ReportOverviewView: UIView!
    
    @IBOutlet weak var reportDetailView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let myColor = UIColor.black;
        self.ReportOverviewView.layer.borderColor=myColor.cgColor
        self.ReportOverviewView.layer.borderWidth=2
        self.reportDetailView.layer.borderColor=myColor.cgColor
        self.reportDetailView.layer.borderWidth=2
        // Do any additional setup after loading the view.
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
