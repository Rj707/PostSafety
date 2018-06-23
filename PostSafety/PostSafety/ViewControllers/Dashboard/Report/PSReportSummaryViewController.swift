//
//  ReportSummaryViewController.swift
//  PostSafety
//
//  Created by Pasha on 18/05/2018.
//  Copyright © 2018 Now Tel. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class PSReportSummaryViewController: UIViewController
{

    @IBOutlet weak var decriptionTextView: IQTextView!
    
    @IBOutlet weak var decriptionTextViewContainer: UIView!
    @IBOutlet weak var backgroundView: UIView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        var result:[String:String] = (UserDefaults.standard.value(forKey: "dict") as? [String : String])!
//        reportTypeTextField.text=result["reporttype"]
//        siteLocationTextField.text=result["location"]
//        categoryTextField.text=result["category"]
//        // Do any additional setup after loading the view.
        
        self.backgroundView.layer.borderWidth=1
        self.backgroundView.layer.borderColor = UIColor(red:255/255, green:75/255, blue:1/255, alpha: 1).cgColor
        
        self.decriptionTextViewContainer.layer.borderWidth=1
        self.decriptionTextViewContainer.layer.borderColor = UIColor(red:255/255, green:75/255, blue:1/255, alpha: 1).cgColor
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setDateTimeForReport()
    {
//        let date = Date()
//        let formatter = DateFormatter()
////        Give the format you want to the formatter:
//        
//        formatter.dateFormat = "dd.MM.yyyy"
////        Get the result string:
//        
//        var result = formatter.string(from: date)
////        Set your label:
//        
//        self.dateTextField.text = result
//        
//        formatter.dateFormat = "hh:mm a"
//        result = formatter.string(from: date)
//        self.timeTextField.text = result
    }
    
    // MARK: - IBActions
    
    @IBAction func backButtonTouched(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func sendReportButtonTouched(_ sender: Any)
    {
        if CEReachabilityManager.isReachable()
        {
            self.performSegue(withIdentifier: "toReportConfirmFromSummary", sender: (Any).self)
        }
        else
        {
            self.performSegue(withIdentifier: "toNoInternetFromSummary", sender: (Any).self)
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
