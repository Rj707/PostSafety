//
//  AnnouncementDetailViewController.swift
//  PostSafety
//
//  Created by Hafiz Saad on 16/05/2018.
//  Copyright © 2018 Now Tel. All rights reserved.
//

import UIKit

class PSFeedDetailViewController: UIViewController
{
    @IBOutlet weak var menuButton:UIButton!
    @IBOutlet weak var feedDetailTitleLabel: UILabel!
    @IBOutlet weak var feedDetailTextView: UITextView!
    @IBOutlet weak var feedDetailAttachmentButton: UIButton!
    var feedDetailTitle: String = ""
    var feedDict = NSDictionary.init()
    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.addMenuAction()
        self.feedDetailTitleLabel.text = self.feedDict["title"] as? String
        self.feedDetailTextView.text = self.feedDict["details"] is NSNull ? "No Data" : self.feedDict["details"] as! String
        self.feedDetailAttachmentButton.setTitle(self.feedDict["pictureUrl"] as? String, for: UIControlState.normal)
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
