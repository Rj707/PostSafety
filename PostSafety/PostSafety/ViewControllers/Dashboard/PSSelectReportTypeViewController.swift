//
//  SelectReportTypeViewController.swift
//  PostSafety
//
//  Created by Hafiz Saad on 16/05/2018.
//  Copyright © 2018 Now Tel. All rights reserved.
//

import UIKit

class PSSelectReportTypeViewController: UIViewController {

    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view1: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view1.layer.borderWidth=1
                self.view2.layer.borderWidth=1
                self.view3.layer.borderWidth=1
                self.view4.layer.borderWidth=1
    self.view1.layer.borderColor=UIColor.init(red: 255/255.0, green: 37/255.0, blue: 1/255.0, alpha: 1.0).cgColor
        self.view2.layer.borderColor=UIColor.init(red: 255/255.0, green: 37/255.0, blue: 1/255.0, alpha: 1.0).cgColor
        self.view3.layer.borderColor=UIColor.init(red: 255/255.0, green: 37/255.0, blue: 1/255.0, alpha: 1.0).cgColor
        self.view4.layer.borderColor=UIColor.init(red: 255/255.0, green: 37/255.0, blue: 1/255.0, alpha: 1.0).cgColor
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
    @IBAction func emgencygestureTouched(_ sender: Any) {
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
