//
//  ReportActionPopupViewController.swift
//  PostSafety
//
//  Created by Pasha on 24/06/2018.
//  Copyright © 2018 Now Tel. All rights reserved.
//

import UIKit

class PSReportActionsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - IBActions
    
    @IBAction func crossButtonTouched(_ sender: UIButton)
    {
        self.dismiss(animated: true)
        {
        }
    }
    
    @IBAction func shareReportButtonTouched(_ sender: UIButton)
    {
        self.definesPresentationContext = true;
        let selectDialogVC : PSShareReportViewController
        selectDialogVC = self.storyboard?.instantiateViewController(withIdentifier: "PSShareReportViewController") as! PSShareReportViewController
        selectDialogVC.view.backgroundColor = UIColor.clear
        selectDialogVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        selectDialogVC.shareReport = 1
        //        self.view.backgroundColor = UIColor.clear
        //        self.modalPresentationStyle = UIModalPresentationStyle.currentContext
        self.present(selectDialogVC, animated: true)
        {
            
        }
    }
    
    @IBAction func closeReportButtonTouched(_ sender: UIButton)
    {
        self.definesPresentationContext = true;
        let closeReportVC : PSCloseReportViewController
        closeReportVC = self.storyboard?.instantiateViewController(withIdentifier: "PSCloseReportViewController") as! PSCloseReportViewController
        closeReportVC.view.backgroundColor = UIColor.clear
        closeReportVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        //        self.view.backgroundColor = UIColor.clear
        //        self.modalPresentationStyle = UIModalPresentationStyle.currentContext
        self.present(closeReportVC, animated: true)
        {
            
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
