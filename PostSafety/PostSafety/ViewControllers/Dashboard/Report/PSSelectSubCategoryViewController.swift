//
//  PSSelectSubCategoryViewController.swift
//  PostSafety
//
//  Created by Hafiz Saad on 21/06/2018.
//  Copyright © 2018 Now Tel. All rights reserved.
//

import UIKit

class PSSelectSubCategoryViewController: UIViewController
{

    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    
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
    
    @IBAction func subCategoryOneGestureTapped(_ sender: Any)
    {
        Global.REPORT?.reportSubcategory = "Subcategory 1"
        let dict:[String:String] = ["reportCategory":"Category 1"]
        UserDefaults.standard.set(dict, forKey: "dict")
        self.performSegue(withIdentifier: "toReportSummaryFromSubcategory", sender: (Any).self)
    }
    @IBAction func subCategoryTwoGestureTapped(_ sender: Any)
    {
        Global.REPORT?.reportSubcategory = "Subcategory 2"
        let dict:[String:String] = ["reportCategory":"Category 2"]
        UserDefaults.standard.set(dict, forKey: "dict")
        self.performSegue(withIdentifier: "toReportSummaryFromSubcategory", sender: (Any).self)
        
    }
    @IBAction func subCategoryThreeGestureTapped(_ sender: Any)
    {
        Global.REPORT?.reportSubcategory = "Subcategory 3"
        let dict:[String:String] = ["reportCategory":"Category 3"]
        UserDefaults.standard.set(dict, forKey: "dict")
        self.performSegue(withIdentifier: "toReportSummaryFromSubcategory", sender: (Any).self)
        
    }
    @IBAction func subCategoryFourGestureTapped(_ sender: Any)
    {
        Global.REPORT?.reportSubcategory = "Subcategory 4"
        let dict:[String:String] = ["reportCategory":"Category 4"]
        UserDefaults.standard.set(dict, forKey: "dict")
        self.performSegue(withIdentifier: "toReportSummaryFromSubcategory", sender: (Any).self)
        
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
