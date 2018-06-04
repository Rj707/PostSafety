//
//  SelectReportTypeViewController.swift
//  PostSafety
//
//  Created by Hafiz Saad on 16/05/2018.
//  Copyright © 2018 Now Tel. All rights reserved.
//

import UIKit
import ACProgressHUD_Swift

class PSSelectReportTypeViewController: UIViewController
{

    var cheklistArray = [Any]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        PSUserInterfaceManager.sharedInstance.showLoaderWithText(text: "Fetching checklists")
        PSAPIManager.sharedInstance.getAllChecklists(success:
        { (dic) in
            
            PSUserInterfaceManager.sharedInstance.hideLoader()
            let tempArray = dic["array"] as! [Any]
            
            for checklistDict in tempArray
            {
                //                            if let dict = peopleDict as? [String: Any], let peopleArray = dict["People"] as? [String]
                if let tempDict = checklistDict as? [String: Any]
                {
                    var checklist = PSChecklist()
                    checklist = checklist.initWithDictionary(dict: tempDict as NSDictionary)
                    self.cheklistArray.append(checklist)
                }
            }
            print(self.cheklistArray)
            
        }, failure:
            
        {
            (error:NSError,statusCode:Int) in
            
            PSUserInterfaceManager.sharedInstance.hideLoader()
            if(statusCode==404)
            {
                PSUserInterfaceManager.showAlert(title: "Checklist", message: ApiResultFailureMessage.InvalidEmailPassword)
            }
            else
            {
                
            }
                
        }, errorPopup: true)
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

    @IBAction func emergencyGestureTapped(_ sender: Any)
    {
        let dict:[String:String] = ["reporttype":"Emergency"]
        UserDefaults.standard.set(dict, forKey: "dict")
        let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "TakePhotoVideoViewController") as! TakePhotoVideoViewController
        navigationController?.pushViewController(vc,
                                                 animated: true)
        
    }
    @IBAction func incidentGestureTapped(_ sender: Any)
    {
        let dict:[String:String] = ["reporttype":"Incident"]
        UserDefaults.standard.set(dict, forKey: "dict")
        let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "TakePhotoVideoViewController") as! TakePhotoVideoViewController
        navigationController?.pushViewController(vc,
                                                 animated: true)
 
    }
    @IBAction func hazardGestureTapped(_ sender: Any)
    {
        
        let dict:[String:String] = ["reporttype":"Hazard"]
        UserDefaults.standard.set(dict, forKey: "dict")
        let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "TakePhotoVideoViewController") as! TakePhotoVideoViewController
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
