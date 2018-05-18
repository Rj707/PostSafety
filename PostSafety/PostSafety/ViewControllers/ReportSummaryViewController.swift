//
//  ReportSummaryViewController.swift
//  PostSafety
//
//  Created by Pasha on 18/05/2018.
//  Copyright © 2018 Now Tel. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class ReportSummaryViewController: UIViewController {

    @IBOutlet weak var decriptionTextView: IQTextView!
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var reportTypeTextField: UITextField!
    @IBOutlet weak var siteLocationTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var timeTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        let myColor = UIColor.black;
        self.decriptionTextView.layer.borderColor=myColor.cgColor
        self.decriptionTextView.layer.borderWidth=2
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sendReportButtonTouched(_ sender: Any) {
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
