//
//  SelectLocationViewController.swift
//  PostSafety
//
//  Created by Hafiz Saad on 16/05/2018.
//  Copyright © 2018 Now Tel. All rights reserved.
//

import UIKit

class PSSelectLocationViewController: UIViewController
{
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    
    var locationselected:Bool=false
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.view1.layer.borderWidth=1
        self.view2.layer.borderWidth=1
        self.view3.layer.borderWidth=1
        self.view4.layer.borderWidth=1
        self.backgroundView.layer.borderWidth=1
        self.view1.layer.borderColor = UIColor(red:255/255, green:75/255, blue:1/255, alpha: 1).cgColor
        self.view2.layer.borderColor = UIColor(red:255/255, green:75/255, blue:1/255, alpha: 1).cgColor
        self.view3.layer.borderColor = UIColor(red:255/255, green:75/255, blue:1/255, alpha: 1).cgColor
        self.view4.layer.borderColor = UIColor(red:255/255, green:75/255, blue:1/255, alpha: 1).cgColor
        self.backgroundView.layer.borderColor = UIColor(red:255/255, green:75/255, blue:1/255, alpha: 1).cgColor

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - IBActions
    
    @IBAction func backButtonTouched(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func locationOneGestureTapped(_ sender: Any)
    {
        locationselected=true
        var result:[String:String] = (UserDefaults.standard.value(forKey: "dict") as? [String : String])!
        result["location"] = "A"
        UserDefaults.standard.set(result, forKey: "dict")
        self.performSegue(withIdentifier: "toReportSummaryFromLocation", sender: (Any).self)
    }
    @IBAction func locationTwoGestureTapped(_ sender: Any)
    {
        locationselected=true
        var result:[String:String] = (UserDefaults.standard.value(forKey: "dict") as? [String : String])!
        result["location"] = "B"
        UserDefaults.standard.set(result, forKey: "dict")
        self.performSegue(withIdentifier: "toReportSummaryFromLocation", sender: (Any).self)
    }
    @IBAction func locationThreeGestureTapped(_ sender: Any)
    {
        locationselected=true
        var result:[String:String] = (UserDefaults.standard.value(forKey: "dict") as? [String : String])!
        result["location"] = "C"
        UserDefaults.standard.set(result, forKey: "dict")
        self.performSegue(withIdentifier: "toReportSummaryFromLocation", sender: (Any).self)
    }
    @IBAction func locationFourGestureTapped(_ sender: Any)
    {
        locationselected=true
        var result:[String:String] = (UserDefaults.standard.value(forKey: "dict") as? [String : String])!
        result["location"] = "D"
        UserDefaults.standard.set(result, forKey: "dict")
        self.performSegue(withIdentifier: "toReportSummaryFromLocation", sender: (Any).self)
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
