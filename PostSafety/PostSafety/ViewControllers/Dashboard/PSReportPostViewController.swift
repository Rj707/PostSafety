//
//  PSReportPostViewController.swift
//  PostSafety
//
//  Created by Rayyan on 24/06/2018.
//  Copyright © 2018 Now Tel. All rights reserved.
//

import UIKit

class PSReportPostViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

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
    
    @IBAction func reportOverviewGestureTapped(_ sender: Any)
    {
        self.definesPresentationContext = true;
        let reportOverViewVC : PSReportOverviewViewController
        let storyBoard = UIStoryboard.init(name: "Admin", bundle: Bundle.main)
        reportOverViewVC = storyBoard.instantiateViewController(withIdentifier: "PSReportOverviewViewController") as! PSReportOverviewViewController
        reportOverViewVC.view.backgroundColor = UIColor.clear
        reportOverViewVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        //        self.view.backgroundColor = UIColor.clear
        //        self.modalPresentationStyle = UIModalPresentationStyle.currentContext
        self.present(reportOverViewVC, animated: true)
        {
            
        }
    }
    
    @IBAction func reportDetailsGestureTapped(_ sender: Any)
    {
        self.definesPresentationContext = true;
        let reportDetailVC : PSReportDetailViewController
        let storyBoard = UIStoryboard.init(name: "Admin", bundle: Bundle.main)
        reportDetailVC = storyBoard.instantiateViewController(withIdentifier: "PSReportDetailViewController") as! PSReportDetailViewController
        reportDetailVC.view.backgroundColor = UIColor.clear
        reportDetailVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        //        self.view.backgroundColor = UIColor.clear
        //        self.modalPresentationStyle = UIModalPresentationStyle.currentContext
        self.present(reportDetailVC, animated: true)
        {
            
        }
    }
    
    @IBAction func reportActionsGestureTapped(_ sender: Any)
    {
        self.definesPresentationContext = true;
        let reportActionVC : UINavigationController
        let storyBoard = UIStoryboard.init(name: "Admin", bundle: Bundle.main)
        reportActionVC = storyBoard.instantiateViewController(withIdentifier: "ReportActionNavViewController") as! UINavigationController
        reportActionVC.view.backgroundColor = UIColor.clear
        reportActionVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        //        self.view.backgroundColor = UIColor.clear
        //        self.modalPresentationStyle = UIModalPresentationStyle.currentContext
        self.present(reportActionVC, animated: true)
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
