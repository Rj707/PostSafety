//
//  SelectCategoryViewController.swift
//  PostSafety
//
//  Created by Pasha on 18/05/2018.
//  Copyright © 2018 Now Tel. All rights reserved.
//

import UIKit

class SelectCategoryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource
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
    
    @IBAction func nextButtonTouched(_ sender: Any) {
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 70;
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell : CategoryTableViewCell = self.catergoryTableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for: indexPath) as! CategoryTableViewCell
        cell.selectionStyle = .none
        if cell.isSelected
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
        selectedCategoryArray.append(categorynames[indexPath.row])
        self.catergoryTableView.reloadData()
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath)
    {
        if let index = selectedCategoryArray.index(of: categorynames[indexPath.row])
        {
            selectedCategoryArray.remove(at: index)
                  self.catergoryTableView.reloadData()
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
