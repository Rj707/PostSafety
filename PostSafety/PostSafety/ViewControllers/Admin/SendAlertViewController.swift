//
//  SendAlertViewController.swift
//  PostSafety
//
//  Created by Pasha on 24/06/2018.
//  Copyright © 2018 Now Tel. All rights reserved.
//

import UIKit

class SendAlertViewController: UIViewController {
    
    override func viewDidLoad()
    {
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
    
    @IBAction func toTextFieldTouched(_ sender: UITapGestureRecognizer)
    {
        self.definesPresentationContext = true;
        let selectDialogVC : SelectDialogViewController
        selectDialogVC = self.storyboard?.instantiateViewController(withIdentifier: "SelectDialogViewController") as! SelectDialogViewController
        selectDialogVC.view.backgroundColor = UIColor.clear
        selectDialogVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        //        self.view.backgroundColor = UIColor.clear
        //        self.modalPresentationStyle = UIModalPresentationStyle.currentContext
        self.present(selectDialogVC, animated: true)
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
