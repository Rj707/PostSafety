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

    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var menuButton: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.configureAndInitialize()
        self.addMenuAction()
        // Do any additional setup after loading the view.
    }
    

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        if PSDataManager.sharedInstance.isPushNotificationNavigation != 5
        {
            PSDataManager.sharedInstance.isPushNotificationNavigation = 5
            self.trainingInboxGestureTapped((Any).self)
        }
    }
    
    func configureAndInitialize()
    {
        self.view1.layer.borderWidth=1
        self.view2.layer.borderWidth=1
        self.view1.layer.borderColor = UIColor(red:255/255, green:75/255, blue:1/255, alpha: 1).cgColor
        self.view2.layer.borderColor = UIColor(red:255/255, green:75/255, blue:1/255, alpha: 1).cgColor
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
            menuButton.addTarget(self.revealViewController(), action: #selector(self.revealViewController().rightRevealToggle(_:)), for: .touchUpInside)
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
            let menuVC = revealViewController().rearViewController as? MenuViewController
            
            menuVC?.dashboardNavViewController = self.navigationController
        }
    }
    
    // MARK: - IBActions
    
    @IBAction func backButtonTouched(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
        
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
