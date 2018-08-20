//
//  PSTrainingViewController.swift
//  PostSafety
//
//  Created by Hafiz Saad on 20/08/2018.
//  Copyright © 2018 Now Tel. All rights reserved.
//

import UIKit

class PSTrainingViewController: UIViewController
{

    @IBOutlet weak var menuButton: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.addMenuAction()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - IBActions
    
    @IBAction func trainingInboxGestureTapped(_ sender: Any)
    {
        let storyboard = UIStoryboard(name: "User", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PSUserFeedViewController") as! PSUserFeedViewController
        vc.feedTitle = "Training"
        vc.route = Route.Trainings.rawValue
        navigationController?.pushViewController(vc,
                                                 animated: true)
    }
    @IBAction func definitionsGestureTapped(_ sender: Any)
    {
        let storyboard = UIStoryboard(name: "User", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PSDefinitionViewController") as! PSDefinitionViewController
        navigationController?.pushViewController(vc,
                                                 animated: true)
    }
    
    func addMenuAction()
    {
        if self.revealViewController() != nil
        {
            menuButton.addTarget(self.revealViewController(), action: #selector(self.revealViewController().revealToggle(_:)), for: .touchUpInside)
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
            let menuVC = revealViewController().rearViewController as? MenuViewController
            
            menuVC?.dashboardNavViewController = self.navigationController
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
