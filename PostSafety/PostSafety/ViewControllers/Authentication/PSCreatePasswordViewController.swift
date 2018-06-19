//
//  SendVerificationCodeViewController.swift
//  PostSafety
//
//  Created by Hafiz Saad on 16/05/2018.
//  Copyright © 2018 Now Tel. All rights reserved.
//

import UIKit

class PSCreatePasswordViewController: UIViewController
{
    @IBOutlet weak var passwordTextFieldContainer:UIView?
    @IBOutlet weak var confirmPasswordTextFieldContainer:UIView?
    @IBOutlet weak var passwordTextField:UITextField?
    @IBOutlet weak var confirmPasswordTextField:UITextField?

    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.passwordTextFieldContainer?.layer.borderWidth = 2
        self.passwordTextFieldContainer?.layer.borderColor = UIColor(red:255/255, green:75/255, blue:1/255, alpha: 1).cgColor
        self.confirmPasswordTextFieldContainer?.layer.borderWidth = 2
        self.confirmPasswordTextFieldContainer?.layer.borderColor = UIColor(red:255/255, green:75/255, blue:1/255, alpha: 1).cgColor

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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
