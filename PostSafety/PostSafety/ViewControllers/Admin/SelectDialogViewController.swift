//
//  SelectDialogViewController.swift
//  PostSafety
//
//  Created by Pasha on 24/06/2018.
//  Copyright © 2018 Now Tel. All rights reserved.
//

import UIKit

class SelectDialogViewController: UIViewController,UITableViewDelegate,UITableViewDataSource
{
    
    @IBOutlet weak var selectDialogTableView:UITableView!
    @IBOutlet weak var selectionButton:UIButton!
    @IBOutlet weak var searchBar:UISearchBar!
    var selectDialogArray = ["a", "b", "c","d", "e", "f","g", "h", "i"]
    var selectedPeopleArray = ["", "", "","", "", "","", "", ""]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.selectDialogTableView.dataSource = self
        self.selectDialogTableView.delegate = self
        
        
        searchBar.backgroundColor = UIColor.clear
        searchBar.backgroundImage = UIImage()
        searchBar.isTranslucent = true
//        searchBar.layer.borderWidth = 2.0
//        searchBar.layer.borderColor = UIColor.brown.cgColor
//        searchBar.layer.cornerRadius = 15.0
//        searchBar.barTintColor = UIColor(red: 255 / 255.0, green: 246 / 255.0, blue: 241 / 255.0, alpha: 1.0)
//        searchBar.backgroundColor = UIColor.clear
//
//        let textField = searchBar.value(forKey: "_searchField") as? UITextField
//        textField?.textColor = UIColor.brown
//        textField?.placeholder = "Search"
//        textField?.leftViewMode = .never
//        //hiding left view
//        textField?.backgroundColor = UIColor.clear
//        textField?.font = UIFont.systemFont(ofSize: 18.0)
//        textField?.setValue(UIColor.brown, forKeyPath: "_placeholderLabel.textColor")
//        let imgview = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 30))
//        imgview.image = UIImage(named: "searchIcon")
//
//        textField?.rightView = imgview
//        textField?.rightViewMode = .always
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - IBActions
    
    @IBAction func selectAllButtonTouched(_ sender: UIButton)
    {
        if selectionButton.titleLabel?.text == "  Select All"
        {
            selectedPeopleArray = ["a", "b", "c","d", "e", "f","g", "h", "i"]
            self.selectionButton.setImage(UIImage.init(named: "selected"), for: UIControlState.normal)
            self.selectionButton.setTitle("  Unselect All", for: UIControlState.normal)
        }
        else
        {
            selectedPeopleArray = ["", "", "","", "", "","", "", ""]
            self.selectionButton.setImage(UIImage.init(named: "unselected"), for: UIControlState.normal)
            self.selectionButton.setTitle("  Select All", for: UIControlState.normal)
        }
        
        selectDialogTableView.reloadData()
    }
    
    @IBAction func crossButtonTouched(_ sender: UIButton)
    {
        self.dismiss(animated: true)
        {
        }
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return selectDialogArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var cell:SelectDialogTableViewCell
        cell = tableView.dequeueReusableCell(withIdentifier: "SelectDialogCell", for: indexPath) as! SelectDialogTableViewCell
        cell.selectionNameLabel?.text = selectDialogArray[indexPath.row]
        
        if selectDialogArray[indexPath.row] == selectedPeopleArray[indexPath.row]
        {
            cell.selectionButton.setImage(UIImage.init(named: "selected"), for: UIControlState.normal)
        }
        else
        {
            cell.selectionButton.setImage(UIImage.init(named: "unselected"), for: UIControlState.normal)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if selectedPeopleArray.contains(selectDialogArray[indexPath.row])
        {
            selectedPeopleArray[indexPath.row] = ""
        }
        else
        {
            selectedPeopleArray[indexPath.row] = selectDialogArray[indexPath.row]
        }
        tableView.reloadData()
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
