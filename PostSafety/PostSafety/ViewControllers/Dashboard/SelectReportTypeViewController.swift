//
//  SelectReportTypeViewController.swift
//  PostSafety
//
//  Created by Hafiz Saad on 16/05/2018.
//  Copyright © 2018 Now Tel. All rights reserved.
//

import UIKit

class SelectReportTypeViewController: UIViewController {

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
