//
//  PSPostedReportViewController.swift
//  PostSafety
//
//  Created by Rayyan on 24/06/2018.
//  Copyright © 2018 Now Tel. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class PSPostedReportViewController: UIViewController
{
    @IBOutlet weak var reportImageView:UIImageView!
    @IBOutlet weak var reportActionsContainer:UIView!
    @IBOutlet weak var menuButton:UIButton!
    @IBOutlet weak var postTitleLabel:UILabel!
    @IBOutlet weak var playVideoButton:UIButton!
    @IBOutlet weak var playVideoContainer:UIView!
    @IBOutlet weak var videoPlayerView:UIView!
    
    var reportPostDict = NSDictionary.init()
    var postTitle = ""
    var videoURL = URL.init(string: "")
    var player = AVPlayer()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.addMenuAction()
        
        postTitleLabel.text = postTitle
        
        if PSDataManager.sharedInstance.loggedInUser?.userTypeByRole == UserType.UserTypeAdmin.rawValue
        {
            self.reportActionsContainer.isHidden = false
        }
        else if PSDataManager.sharedInstance.loggedInUser?.userTypeByRole == UserType.UserTypeNormal.rawValue
        {
            self.reportActionsContainer.isHidden = true
        }
        
        if reportPostDict["fileType"] as! String == "Video"
        {
            self.downloadThumbnail(WithURL: URL.init(string: String(format: "%@%@", reportPostDict["url"] as! String,reportPostDict["fileName"] as! String))!)

        }
        else if reportPostDict["fileName"]  is NSNull
        {
            
        }
        else
        {
            print(reportPostDict["fileName"] ?? "")
            
            self.downloadReportImage()
        }
        
    }
    

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Private
    
    func downloadReportImage()
    {
        PSUserInterfaceManager.sharedInstance.showLoaderWithText(text: "Loading Image")
        PSAPIManager.sharedInstance.getDataFromUrl(url: URL.init(string: String(format: "http://postsafety.anadeemus.ca/UploadImages/%@", reportPostDict["fileName"] as! String))!)
        { (data, response, error) in
            
            PSUserInterfaceManager.sharedInstance.hideLoader()
            
            if error ==  nil
            {
                DispatchQueue.main.async
                {
                    _ = UIImage(data: data!)
                    if (UIImage(data: data!) != nil)
                    {
                        self.reportImageView.image = UIImage(data: data!)
                    }
                    else
                    {
                        print("None")
                        PSUserInterfaceManager.showAlert(title: "Loading Image", message: "Something went wrong while loading Image")
                    }
                }
            }
            else
            {
                PSUserInterfaceManager.showAlert(title: "Loading Image", message: "Something went wrong while loading Image")
            }
        }
    }
    
    func downloadThumbnail(WithURL url:URL) -> Void
    {
        PSUserInterfaceManager.sharedInstance.showLoaderWithText(text: "Loading Video")
        self.videoURL = url
//        self.videoURL = URL.init(string: "http://techslides.com/demos/sample-videos/small.mp4")
        DispatchQueue.global().async
        {
            let asset = AVAsset(url: url)
            let assetImgGenerate : AVAssetImageGenerator = AVAssetImageGenerator(asset: asset)
            assetImgGenerate.appliesPreferredTrackTransform = true
            let time = CMTimeMake(1, 2)
            let img = try? assetImgGenerate.copyCGImage(at: time, actualTime: nil)
            if img != nil
            {
                let frameImg  = UIImage(cgImage: img!)
                DispatchQueue.main.async(execute:
                {
                    PSUserInterfaceManager.sharedInstance.hideLoader()
                    self.reportImageView.image = frameImg
                    self.playVideoButton.isHidden = false
                    self.playVideoButton.setImage(UIImage.init(named: "play"), for: .normal)
                    self.playVideoContainer.isHidden = false
                })
            }
            else
            {
                DispatchQueue.main.async(execute:
                {
                    PSUserInterfaceManager.sharedInstance.hideLoader()
                    self.reportImageView.image = UIImage.init(named: "default-thumb.jpg")
                    self.playVideoButton.setImage(UIImage.init(named: ""), for: .normal)
                    self.playVideoButton.isHidden = false
                    self.playVideoContainer.isHidden = false
                })
                
            }
            
//            let videoURL = URL(string: "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")
//            self.videoURL = videoURL
//            self.player = AVPlayer(url: self.videoURL!)
//            let playerLayer = AVPlayerLayer(player: self.player)
//            playerLayer.frame = self.videoPlayerView.frame
//            self.videoPlayerView.layer.addSublayer(playerLayer)
//            self.player.play()
            
        }
        
        
    }
    
    func createThumbnailOfVideoFromRemoteUrl(url: String) -> UIImage?
    {
        let asset = AVAsset(url: URL(string: url)!)
        let assetImgGenerate = AVAssetImageGenerator(asset: asset)
        assetImgGenerate.appliesPreferredTrackTransform = true
        //Can set this to improve performance if target size is known before hand
        //assetImgGenerate.maximumSize = CGSize(width,height)
        let time = CMTimeMakeWithSeconds(1.0, 600)
        do
        {
            let img = try assetImgGenerate.copyCGImage(at: time, actualTime: nil)
            let thumbnail = UIImage(cgImage: img)
            return thumbnail
        }
        catch
        {
            print(error.localizedDescription)
            return nil
        }
    }
    
    
    // MARK: - IBActions
    
    @IBAction func playVideoGestureTapped(_ sender: Any)
    {
        let player = AVPlayer(url: self.videoURL!)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true)
        {
            playerViewController.player!.play()
        }
    }
    
    @IBAction func backButtonTouched(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func reportOverviewGestureTapped(_ sender: Any)
    {
        self.definesPresentationContext = true;
        let reportOverViewVC : PSPostedReportOverviewViewController
        let storyBoard = UIStoryboard.init(name: "Admin", bundle: Bundle.main)
        reportOverViewVC = storyBoard.instantiateViewController(withIdentifier: "PSPostedReportOverviewViewController") as! PSPostedReportOverviewViewController
        reportOverViewVC.reportOverviewDict = self.reportPostDict
        reportOverViewVC.view.backgroundColor = UIColor.clear
        reportOverViewVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        //        self.view.backgroundColor = UIColor.clear
        //        self.modalPresentationStyle = UIModalPresentationStyle.currentContext
        
        self.present(reportOverViewVC, animated: true)
        {
            
        }
    }
    
    @IBAction func reportDetailsGestureTapped(_ sender: Any)
    {
        self.definesPresentationContext = true;
        let reportDetailVC : PSPostedReportDetailViewController
        let storyBoard = UIStoryboard.init(name: "Admin", bundle: Bundle.main)
        reportDetailVC = storyBoard.instantiateViewController(withIdentifier: "PSPostedReportDetailViewController") as! PSPostedReportDetailViewController
        reportDetailVC.reportDetailsDict = self.reportPostDict
        reportDetailVC.view.backgroundColor = UIColor.clear
        reportDetailVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        //        self.view.backgroundColor = UIColor.clear
        //        self.modalPresentationStyle = UIModalPresentationStyle.currentContext
        self.present(reportDetailVC, animated: true)
        {
            
        }
    }
    
    @IBAction func reportActionsGestureTapped(_ sender: Any)
    {
        self.definesPresentationContext = true;
        let reportActionVC : UINavigationController
        let storyBoard = UIStoryboard.init(name: "Admin", bundle: Bundle.main)
        reportActionVC = storyBoard.instantiateViewController(withIdentifier: "ReportActionNavViewController") as! UINavigationController
        reportActionVC.view.backgroundColor = UIColor.clear
        reportActionVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        //        self.view.backgroundColor = UIColor.clear
        //        self.modalPresentationStyle = UIModalPresentationStyle.currentContext
        self.present(reportActionVC, animated: true)
        {
            
        }
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
