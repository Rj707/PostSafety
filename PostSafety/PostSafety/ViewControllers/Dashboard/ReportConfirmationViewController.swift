//
//  ReportConfirmationViewController.swift
//  PostSafety
//
//  Created by Hafiz Saad on 16/05/2018.
//  Copyright © 2018 Now Tel. All rights reserved.
//

import UIKit

class ReportConfirmationViewController: UIViewController {

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
        if let viewControllers = self.navigationController?.viewControllers
        {
            for viewController in viewControllers
            {
                // some process
                if viewController is DashboardViewController
                {
                    self.navigationController?.popToViewController(viewController, animated: true)
                    break
                }
            }
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func returnToDashboardButtonTouched(_ sender: UIButton)
    {
        if let viewControllers = self.navigationController?.viewControllers
        {
            for viewController in viewControllers
            {
                // some process
                if viewController is DashboardViewController
                {
                    self.navigationController?.popToViewController(viewController, animated: true)
                    break
                }
            }
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
