//
//  SelectLocationViewController.swift
//  PostSafety
//
//  Created by Hafiz Saad on 16/05/2018.
//  Copyright © 2018 Now Tel. All rights reserved.
//

import UIKit

class SelectLocationViewController: UIViewController {
    
    var locationselected:Bool=false
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
    
    @IBAction func CgestureTapped(_ sender: Any)
    {
        locationselected=true
        var result:[String:String] = (UserDefaults.standard.value(forKey: "dict") as? [String : String])!
        result["location"] = "A"
        UserDefaults.standard.set(result, forKey: "dict")
    }
    @IBAction func AgestureTapped(_ sender: Any)
    {
                locationselected=true
        var result:[String:String] = (UserDefaults.standard.value(forKey: "dict") as? [String : String])!
        result["location"] = "C"
        UserDefaults.standard.set(result, forKey: "dict")
    }
    @IBAction func BgestureTapped(_ sender: Any)
    {
                locationselected=true
        var result:[String:String] = (UserDefaults.standard.value(forKey: "dict") as? [String : String])!
        result["location"] = "B"
        UserDefaults.standard.set(result, forKey: "dict")
    }
    @IBAction func DgestureTapped(_ sender: Any)
    {
                locationselected=true
        var result:[String:String] = (UserDefaults.standard.value(forKey: "dict") as? [String : String])!
        result["location"] = "D"
        UserDefaults.standard.set(result, forKey: "dict")
    }
    @IBAction func nextButtonTouched(_ sender: Any)
    {
        if locationselected
        {}
        else
        {
            var result:[String:String] = (UserDefaults.standard.value(forKey: "dict") as? [String : String])!
            result["location"] = "A"
            UserDefaults.standard.set(result, forKey: "dict")
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
