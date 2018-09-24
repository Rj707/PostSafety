//
//  PSPostedReportAttachmentViewController.swift
//  PostSafety
//
//  Created by Hafiz Saad on 24/09/2018.
//  Copyright © 2018 Now Tel. All rights reserved.
//

import UIKit

class PSPostedReportAttachmentViewController: UIViewController
{

    @IBOutlet weak var attachmentImageVIew:UIImageView!
    var attachmentImage = UIImage()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.attachmentImageVIew.image = self.attachmentImage;
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
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
