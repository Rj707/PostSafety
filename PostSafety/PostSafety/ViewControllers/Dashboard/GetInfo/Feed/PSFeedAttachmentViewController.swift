//
//  PSFeedAttachmentViewController.swift
//  PostSafety
//
//  Created by Rayyan on 10/08/2018.
//  Copyright © 2018 Now Tel. All rights reserved.
//

import UIKit

class PSFeedAttachmentViewController: UIViewController,UIWebViewDelegate
{

    @IBOutlet weak var attachmentWebView : UIWebView?
    var attachmentString = "0anadeemus.jpg"
    var baseURLForAttachment = ""
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        attachmentWebView?.delegate = self
        

        let attachURL = String(format: "%@%@", baseURLForAttachment,attachmentString)
        let urlString = attachURL.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)

        self.attachmentWebView?.loadRequest(URLRequest.init(url: URL.init(string: urlString!)!))
        
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
        PSUserInterfaceManager.sharedInstance.showLoaderWithText(text: "Loading Content")
    }
    
    
    @IBAction func dismissWebView()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    public func webViewDidStartLoad(_ webView: UIWebView)
    {
        
    }
    
    
    public func webViewDidFinishLoad(_ webView: UIWebView)
    {
        PSUserInterfaceManager.sharedInstance.hideLoader()
    }

    public func webView(_ webView: UIWebView, didFailLoadWithError error: Error)
    {
        PSUserInterfaceManager.sharedInstance.hideLoader()
        PSUserInterfaceManager.showAlert(title: "Something Went wrong", message: error.localizedDescription)
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
