//
//  PSPotentiallySeriousIncidentViewController.swift
//  PostSafety
//
//  Created by Hafiz Saad on 21/06/2018.
//  Copyright © 2018 Now Tel. All rights reserved.
//

import UIKit

class PSPotentiallySeriousIncidentViewController: UIViewController
{

    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view3: UIView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.view1.layer.borderWidth=1
        self.view2.layer.borderWidth=1
        self.view3.layer.borderWidth=1
        self.view3.layer.borderColor = UIColor(red:255/255, green:75/255, blue:1/255, alpha: 1).cgColor
        self.view1.layer.borderColor = UIColor(red:255/255, green:75/255, blue:1/255, alpha: 1).cgColor
        self.view2.layer.borderColor = UIColor(red:255/255, green:75/255, blue:1/255, alpha: 1).cgColor
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - IBActions
    
    @IBAction func backButtonTouched(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func yesGestureTapped(_ sender: Any)
    {
        Global.REPORT?.isReportPSI = "Yes"
        
        let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PSSelectLocationViewController") as! PSSelectLocationViewController
        navigationController?.pushViewController(vc,
                                                 animated: true)
        
    }
    @IBAction func noGestureTapped(_ sender: Any)
    {
        Global.REPORT?.isReportPSI = "No"
     
        let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PSSelectLocationViewController") as! PSSelectLocationViewController
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
