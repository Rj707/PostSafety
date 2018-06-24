//
//  PSNoConnectionViewController.swift
//  PostSafety
//
//  Created by Rayyan on 21/06/2018.
//  Copyright © 2018 Now Tel. All rights reserved.
//

import UIKit

class PSNoConnectionViewController: UIViewController {

    @IBOutlet weak var noConnectionContainer : UIView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.noConnectionContainer.layer.borderWidth=2
        self.noConnectionContainer.layer.borderColor = UIColor(red:255/255, green:75/255, blue:1/255, alpha: 1).cgColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func returnToDashboardButtonTouched(_ sender: UIButton)
    {
        if let viewControllers = self.navigationController?.viewControllers
        {
            for viewController in viewControllers
            {
                // some process
                if viewController is PSDashboardViewController
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
