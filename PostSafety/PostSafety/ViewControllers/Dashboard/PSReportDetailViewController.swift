//
//  ReportDetailViewController.swift
//  PostSafety
//
//  Created by Pasha on 18/05/2018.
//  Copyright © 2018 Now Tel. All rights reserved.
//

import UIKit

class PSReportDetailViewController: UIViewController
{
    var reportDetailsDict = NSDictionary.init()
    @IBOutlet weak var reportDetailsLable: UILabel!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.reportDetailsLable.text = self.reportDetailsDict["details"] is NSNull ? "None" : self.reportDetailsDict["details"] as! String
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning()
    {
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
