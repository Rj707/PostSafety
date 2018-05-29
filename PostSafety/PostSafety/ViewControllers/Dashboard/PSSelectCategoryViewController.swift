//
//  SelectCategoryViewController.swift
//  PostSafety
//
//  Created by Pasha on 18/05/2018.
//  Copyright © 2018 Now Tel. All rights reserved.
//

import UIKit

class PSSelectCategoryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource
{

    @IBOutlet weak var catergoryTableView: UITableView!
     let categorynames = ["","","","","", "Other"]
    var selectedCategoryArray = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.catergoryTableView.allowsMultipleSelection=true
        

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
    
    @IBAction func nextButtonTouched(_ sender: Any)
    {
        if selectedCategoryArray.count>0
        {
            
            var result:[String:String] = (UserDefaults.standard.value(forKey: "dict") as? [String : String])!
            result["category"] = categorynames[Int(selectedCategoryArray[0])!]
                UserDefaults.standard.set(result, forKey: "dict")
        }
        else
        {
            let alert = UIAlertController(title: "Alert", message: "Please Select Category", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 70;
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell : CategoryTableViewCell = self.catergoryTableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for: indexPath) as! CategoryTableViewCell
        cell.selectionStyle = .none
        let myString : String
        if selectedCategoryArray.count>0 {
              myString = selectedCategoryArray[0]
        }
        else
        {
              myString = "7"
        }
        if indexPath.row ==  Int(myString)
        {
        cell.configureCell(isselected: true, category: categorynames[indexPath.row])
        }
        else
        {
            cell.configureCell(isselected: false, category: categorynames[indexPath.row])
        }
        
        //  cell.textLabel?.text = "Section \(indexPath.section) Row \(indexPath.row)"
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
       
            return 6;
        
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
//        let selectedItems = catergoryTableView.indexPathsForSelectedRows
//
//        for index in selectedItems!
//        {
//            if index != indexPath
//            {
//            catergoryTableView.deselectRow(at: indexPath, animated: false)
//
//            }
//
//        }
        
        selectedCategoryArray.removeAll()
        selectedCategoryArray.append(String(indexPath.row))
        self.catergoryTableView.reloadData()
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
