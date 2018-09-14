//
//  PSNoConnectionViewController.swift
//  PostSafety
//
//  Created by Rayyan on 21/06/2018.
//  Copyright © 2018 Now Tel. All rights reserved.
//

import UIKit

class PSNoConnectionViewController: UIViewController
{

    @IBOutlet weak var noConnectionContainer : UIView!
    @IBOutlet weak var call911Button:UIButton!
    @IBOutlet weak var takeAnotherVideoButton:UIButton!
    
    public var delegate:PSEmergencyReportConfirmationViewControllerDelegate!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.noConnectionContainer.layer.borderWidth=2
        self.noConnectionContainer.layer.borderColor = UIColor(red:255/255, green:75/255, blue:1/255, alpha: 1).cgColor
//        print(PSDataManager.sharedInstance.report?.reportType ?? "Nothing")
        if PSDataManager.sharedInstance.report?.reportType != "Emergency"
        {
            self.call911Button.isHidden =  true
            self.takeAnotherVideoButton.isHidden =  true
            
        }
        else
        {
            self.call911Button.isHidden =  false
            self.takeAnotherVideoButton.isHidden =  false
        }
    }

    override func didReceiveMemoryWarning()
    {
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
                    PSDataManager.sharedInstance.offlinePostDictionary = NSMutableDictionary.init()
                    self.navigationController?.popToViewController(viewController, animated: true)
                    break
                }
            }
        }
    }
    
    @IBAction func call911ButtonTouched(_ sender: UIButton)
    {
        var phone = "911"
        phone = phone.removingWhitespaces()
        var newPhone = ""
        for i in (phone.characters)
        {
            switch (i)
            {
            case "0","1","2","3","4","5","6","7","8","9" : newPhone = newPhone + String(i)
            default : print("Removed invalid character.")
            }
        }
        
        if let url = URL(string:"tel://\(String(describing: newPhone))"), UIApplication.shared.canOpenURL(url)
        {
            UIApplication.shared.openURL(url)
        }
        else
        {
            print("Issue")
        }
    }
    
    @IBAction func takeAnotherVideoButtonTouched(_ sender: UIButton)
    {
        
        if let viewControllers = self.navigationController?.viewControllers
        {
            for viewController in viewControllers
            {
                // some process
                if viewController is TakePhotoVideoViewController
                {
                    self.delegate.takeAnotherOfflineVideoForEmergency()
                    self.navigationController?.popToViewController(viewController, animated: true)
                    return
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
