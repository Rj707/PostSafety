//
//  ReportSummaryViewController.swift
//  PostSafety
//
//  Created by Pasha on 18/05/2018.
//  Copyright © 2018 Now Tel. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class PSReportSummaryViewController: UIViewController {

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
        
        self.setDateTimeForReport()
        var result:[String:String] = (UserDefaults.standard.value(forKey: "dict") as? [String : String])!
      reportTypeTextField.text=result["reporttype"]
        siteLocationTextField.text=result["location"]
        categoryTextField.text=result["category"]
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setDateTimeForReport()
    {
        let date = Date()
        let formatter = DateFormatter()
//        Give the format you want to the formatter:
        
        formatter.dateFormat = "dd.MM.yyyy"
//        Get the result string:
        
        var result = formatter.string(from: date)
//        Set your label:
        
        self.dateTextField.text = result
        
        formatter.dateFormat = "hh:mm a"
        result = formatter.string(from: date)
        self.timeTextField.text = result
    }
    
    // MARK: - IBActions
    
    @IBAction func backButtonTouched(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func sendReportButtonTouched(_ sender: Any)
    {
       
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
