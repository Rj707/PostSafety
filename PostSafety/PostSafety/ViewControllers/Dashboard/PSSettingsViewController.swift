//
//  PSSettingsViewController.swift
//  PostSafety
//
//  Created by Rayyan on 25/06/2018.
//  Copyright © 2018 Now Tel. All rights reserved.
//

import UIKit

class PSSettingsViewController: UIViewController
{
    @IBOutlet weak var passwordTextFieldContainer:UIView?
    @IBOutlet weak var confirmPasswordTextFieldContainer:UIView?
    @IBOutlet weak var phoneNumberTextFieldContainer:UIView?
    
    @IBOutlet weak var passwordTextField:UITextField?
    @IBOutlet weak var confirmPasswordTextField:UITextField?
    @IBOutlet weak var phoneNumberTextField:UITextField?
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.passwordTextFieldContainer?.layer.borderWidth = 2
        self.passwordTextFieldContainer?.layer.borderColor = UIColor(red:255/255, green:75/255, blue:1/255, alpha: 1).cgColor
        self.confirmPasswordTextFieldContainer?.layer.borderWidth = 2
        self.confirmPasswordTextFieldContainer?.layer.borderColor = UIColor(red:255/255, green:75/255, blue:1/255, alpha: 1).cgColor
        self.phoneNumberTextFieldContainer?.layer.borderWidth = 2
        self.phoneNumberTextFieldContainer?.layer.borderColor = UIColor(red:255/255, green:75/255, blue:1/255, alpha: 1).cgColor
        
        // Do any additional setup after loading the view.
    }

    // MARK: - IBActions
    
    @IBAction func backButtonTouched(_ sender: UIButton)
    {
        var array = self.navigationController?.viewControllers
//        [self.revealViewController.navigationController popViewControllerAnimated:YES]
        self.revealViewController().navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
