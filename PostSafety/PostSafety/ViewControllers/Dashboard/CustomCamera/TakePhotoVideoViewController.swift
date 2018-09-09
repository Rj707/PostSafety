//
//  TakePhotoVideoViewController.swift
//  PostSafety
//
//  Created by Hafiz Saad on 16/05/2018.
//  Copyright © 2018 Now Tel. All rights reserved.
//

import UIKit


class TakePhotoVideoViewController: SwiftyCamViewController, SwiftyCamViewControllerDelegate,PhotoViewControllerDelegate,VideoViewControllerDelegate,PSEmergencyReportConfirmationViewControllerDelegate
{

    @IBOutlet weak var captureButton: SwiftyRecordButton!
    @IBOutlet weak var flipCameraButton: UIButton!
    @IBOutlet weak var flashButton: UIButton!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var photoVideoLabel: UILabel!
    
    var incidentTypeID = 0
    var employeeID = 0
    var reportID = 0
    var checkList = PSChecklist(incidentType: 0, typeName: "", checkList: 0, checklistDetails: NSDictionary())
    
    var counter = 0.0
    var timer = Timer()
    
    // MARK: Implementation
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.configureAndInitialize()
    }
    
    
    override var prefersStatusBarHidden: Bool
    {
        return true
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        captureButton.delegate = self
        timeLabel.isHidden = true
    }
    
    func configureAndInitialize()
    {
        if PSDataManager.sharedInstance.report?.reportType != "Emergency"
        {
            self.photoVideoLabel.text = "Tap for photo, hold down for video"
        }
        else
        {
            self.photoVideoLabel.text = "Hold down for video"
        }
        
        cameraDelegate = self
        maximumVideoDuration = 10.0
        shouldUseDeviceOrientation = true
        allowAutoRotate = true
        audioEnabled = true
        
        let transform = CGAffineTransform(scaleX: 1.5, y: 10.0)
        progressView.transform = transform
        progressView.clipsToBounds = true
        progressView.layer.cornerRadius = progressView.frame.height/2
        
        self.employeeID = (PSDataManager.sharedInstance.loggedInUser?.employeeId)!
        if self.incidentTypeID == 0
        {
            self.incidentTypeID = (PSDataManager.sharedInstance.report?.incidentType)!
        }
        else
        {
            
        }
        
        self.createReport()
    }
    
    // MARK: SwiftyCamViewController
    
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didTake photo: UIImage)
    {
        if PSDataManager.sharedInstance.report?.reportType != "Emergency"
        {
            let newVC = PhotoViewController(image: photo)
            newVC.delegate = self
            self.present(newVC, animated: true, completion: nil)
        }
    }
    
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didBeginRecordingVideo camera: SwiftyCamViewController.CameraSelection)
    {
        self.counter = 0.0
        timeLabel.text = "00:00:00"
        timeLabel.isHidden = false
        self.startTimer()
        print("Did Begin Recording")
        captureButton.growButton()
        UIView.animate(withDuration: 0.25, animations:
        {
            self.flashButton.alpha = 0.0
            self.flipCameraButton.alpha = 0.0
        })
    }
    
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didFinishRecordingVideo camera: SwiftyCamViewController.CameraSelection)
    {
        timeLabel.isHidden = true
        print("Did finish Recording")
        captureButton.shrinkButton()
        UIView.animate(withDuration: 0.25, animations:
        {
            self.flashButton.alpha = 1.0
            self.flipCameraButton.alpha = 1.0
        })
    }
    
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didFinishProcessVideoAt url: URL)
    {
        let newVC = VideoViewController(videoURL: url)
        newVC.delegate = self
        self.present(newVC, animated: true, completion: nil)
    }
    
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didFocusAtPoint point: CGPoint)
    {
        let focusView = UIImageView(image: #imageLiteral(resourceName: "focus"))
        focusView.center = point
        focusView.alpha = 0.0
        view.addSubview(focusView)
        
        UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveEaseInOut, animations:
        {
            focusView.alpha = 1.0
            focusView.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
        }, completion:
        { (success) in
            UIView.animate(withDuration: 0.15, delay: 0.5, options: .curveEaseInOut, animations:
                {
                focusView.alpha = 0.0
                focusView.transform = CGAffineTransform(translationX: 0.6, y: 0.6)
            }, completion: { (success) in
                focusView.removeFromSuperview()
            })
        })
    }
    
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didChangeZoomLevel zoom: CGFloat)
    {
        print(zoom)
    }
    
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didSwitchCameras camera: SwiftyCamViewController.CameraSelection)
    {
        print(camera)
    }
    
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didFailToRecordVideo error: Error)
    {
        print(error)
    }
    
    // MARK: IBActions
    
    @IBAction func backButtonTouched(_ sender: UITapGestureRecognizer)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cameraSwitchTapped(_ sender: Any)
    {
        switchCamera()
    }
    
    @IBAction func toggleFlashTapped(_ sender: Any)
    {
        flashEnabled = !flashEnabled
        
        if flashEnabled == true
        {
            flashButton.setImage(#imageLiteral(resourceName: "flash"), for: UIControlState())
        }
        else
        {
            flashButton.setImage(#imageLiteral(resourceName: "flashOutline"), for: UIControlState())
        }
    }
    
    // MARK: Image Video Delegates
    
    func sendVideo(videoData:Data)
    {
        // TODO: Offline Post Submisison
        PSDataManager.sharedInstance.offlinePostDictionary.setValue("Video", forKey: "FileType")
        PSDataManager.sharedInstance.offlinePostDictionary.setValue(videoData, forKey: "data")
        if CEReachabilityManager.isReachable()
        {
            
            self.progressView.isHidden = false
            PSUserInterfaceManager.sharedInstance.showLoaderWithText(text: "Uploading Video")
            PSAPIManager.sharedInstance.uploadImageFor(ReportId: String(self.reportID), Type: "Video", data:videoData , success:
            { (dic) in
                self.progressView.isHidden = true
                PSUserInterfaceManager.sharedInstance.hideLoader()
                if PSDataManager.sharedInstance.report?.reportType != "Emergency"
                {
                    let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "PSSelectCategoryViewController") as! PSSelectCategoryViewController
                    vc.checklistId = self.checkList.checkList
                    vc.cheklistDetailsArray = self.checkList.checklistDetails["checklistDetails"] as! [Any]
                    self.progressView.setProgress(Float(0), animated: true)
//                    self.timeLabel.text = "00:00:00"
                    self.timer.invalidate()
                    self.navigationController?.pushViewController(vc,
                                                                  animated: true)
                }
                else
                {
                    self.progressView.setProgress(Float(0), animated: true)
//                    self.timeLabel.text = "00:00:00"
                    self.timer.invalidate()
                    self.updateEmergencyReport()
                }
                    
            }, failure:
                
            { (error:NSError,statusCode:Int) in
                
                PSUserInterfaceManager.sharedInstance.hideLoader()
                self.progressView.isHidden = true
            },
               progress:
            {
                (prog:Double) in
                
                self.progressView.setProgress(Float(prog), animated: true)
                    
            }, errorPopup: true)
        }
        else
        {
//            PSUserInterfaceManager.showAlert(title: "Uploading Image", message: ApiErrorMessage.NoNetwork)
            if PSDataManager.sharedInstance.report?.reportType != "Emergency"
            {
                let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "PSSelectCategoryViewController") as! PSSelectCategoryViewController
                vc.checklistId = self.checkList.checkList
                vc.cheklistDetailsArray = self.checkList.checklistDetails["checklistDetails"] as! [Any]
                self.progressView.setProgress(Float(0), animated: true)
                //                    self.timeLabel.text = "00:00:00"
                self.timer.invalidate()
                DispatchQueue.main.async
                {
                    print("This is run on the main queue, after the previous code in outer block")
                    self.navigationController?.pushViewController(vc,
                                                                  animated: true)
                }
            }
            else
            {
                let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "PSNoConnectionViewController") as! PSNoConnectionViewController
                self.navigationController?.pushViewController(vc,
                                                              animated: true)
                
                // TODO: Offline Post Submisison
//                print(PSDataManager.sharedInstance.offlinePostDictionary)
                PSDataManager.sharedInstance.offlinePostDictionary.setValue("N/A", forKey: "Details")
                var post : PSPost?
                post = PSPost.init()
                post = post?.initWithDictionary(dict: PSDataManager.sharedInstance.offlinePostDictionary as NSDictionary)
                PSDataManager.sharedInstance.offlinePost = post
            }
        }
        
    }
    
    func sendPhoto(imageData: Data)
    {
        // TODO: Offline Post Submisison
        PSDataManager.sharedInstance.offlinePostDictionary.setValue("Image", forKey: "FileType")
        PSDataManager.sharedInstance.offlinePostDictionary.setValue(imageData, forKey: "data")
        if CEReachabilityManager.isReachable()
        {
            self.progressView.isHidden = false
            let image = UIImage(data: imageData)
            
            PSUserInterfaceManager.sharedInstance.showLoaderWithText(text: "Uploading Image")
            PSAPIManager.sharedInstance.uploadImageFor(ReportId: String(self.reportID), Type: "Image", data:(image?.jpeg(UIImage.JPEGQuality.low))! , success:
            { (dic) in
                
                self.progressView.isHidden = true
                PSUserInterfaceManager.sharedInstance.hideLoader()
                print(Global.REPORT?.reportType ?? "No Type Found")
                print(PSDataManager.sharedInstance.report?.reportType ?? "No Type Found")
                if PSDataManager.sharedInstance.report?.reportType != "Emergency"
                {
                    let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "PSSelectCategoryViewController") as! PSSelectCategoryViewController
                    vc.checklistId = self.checkList.checkList
                    vc.cheklistDetailsArray = self.checkList.checklistDetails["checklistDetails"] as! [Any]
                    self.progressView.setProgress(Float(0), animated: true)
//                    self.timeLabel.text = "00:00:00"
                    self.timer.invalidate()
                    self.navigationController?.pushViewController(vc,
                                                                  animated: true)
                }
                else
                {
                    self.progressView.setProgress(Float(0), animated: true)
//                    self.timeLabel.text = "00:00:00"
                    self.timer.invalidate()
                    self.updateEmergencyReport()
                }
                    
            }, failure:
                
            { (error:NSError,statusCode:Int) in
                self.progressView.isHidden = true
                PSUserInterfaceManager.sharedInstance.hideLoader()
                    
            }, progress:
            {
                (prog:Double) in
                
                self.progressView.setProgress(Float(prog), animated: true)
                
            }, errorPopup: true)
        }
        else
        {
//            PSUserInterfaceManager.showAlert(title: "Uploading Image", message: ApiErrorMessage.NoNetwork)
            if PSDataManager.sharedInstance.report?.reportType != "Emergency"
            {
                let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "PSSelectCategoryViewController") as! PSSelectCategoryViewController
                vc.checklistId = self.checkList.checkList
                vc.cheklistDetailsArray = self.checkList.checklistDetails["checklistDetails"] as! [Any]
                self.progressView.setProgress(Float(0), animated: true)
                //                    self.timeLabel.text = "00:00:00"
                self.timer.invalidate()
                DispatchQueue.main.async
                {
                    print("This is run on the main queue, after the previous code in outer block")
                    self.navigationController?.pushViewController(vc,
                                                                  animated: true)
                }
            }
            else
            {
                let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "PSNoConnectionViewController") as! PSNoConnectionViewController
                self.navigationController?.pushViewController(vc,
                                                              animated: true)
                
                // TODO: Offline Post Submisison
//                print(PSDataManager.sharedInstance.offlinePostDictionary)
                PSDataManager.sharedInstance.offlinePostDictionary.setValue("N/A", forKey: "Details")
                var post : PSPost?
                post = PSPost.init()
                post = post?.initWithDictionary(dict: PSDataManager.sharedInstance.offlinePostDictionary as NSDictionary)
                PSDataManager.sharedInstance.offlinePost = post
            }
        }
    }
    
    func takeAnotherVideoForEmergency()
    {
        if self.incidentTypeID == 0
        {
            self.incidentTypeID = (PSDataManager.sharedInstance.report?.incidentType)!
        }
        
        self.createReport()
    }
    
    // MARK: APIs
    
    func updateEmergencyReport()
    {
        if CEReachabilityManager.isReachable()
        {
            PSUserInterfaceManager.sharedInstance.showLoaderWithText(text: "Updating Report")
            var report = PSReport.init()
            report = PSDataManager.sharedInstance.report!
            PSAPIManager.sharedInstance.updateReportFor(ReportId: String(report.reportID), LocationId: String(0), Title: "N/A", Details: "N/A", CatagoryId: String(report.categoryID), SubCatagory: "0", IsPSI: NSNumber.init(booleanLiteral: false) as! Bool, success:
            { (dict) in
                
                PSUserInterfaceManager.sharedInstance.hideLoader()
                //                http://postsafety.anadeemus.ca/api/UpdateReport/?SubCatagory=0&Details=&CatagoryId=0&Title=&IsPSI=0&ReportId=10411&LocationId=0
                
                let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "PSEmergencyReportConfirmationViewController") as! PSEmergencyReportConfirmationViewController
                vc.delegate = self
                self.navigationController?.pushViewController(vc,
                                                              animated: true)
                    
            },
                                                        failure:
            { (error, stausCode) in
                
                PSUserInterfaceManager.sharedInstance.hideLoader()
                PSUserInterfaceManager.showAlert(title: "Something went wrong", message: error.localizedDescription)
                
            }, errorPopup: true)
            
            
        }
        else
        {
            let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "PSNoConnectionViewController") as! PSNoConnectionViewController
            self.navigationController?.pushViewController(vc,
                                                          animated: true)
            
            // TODO: Offline Post Submisison
//            print(PSDataManager.sharedInstance.offlinePostDictionary)
            PSDataManager.sharedInstance.offlinePostDictionary.setValue("N/A", forKey: "Details")
            var post : PSPost?
            post = PSPost.init()
            post = post?.initWithDictionary(dict: PSDataManager.sharedInstance.offlinePostDictionary as NSDictionary)
            PSDataManager.sharedInstance.offlinePost = post
        }
    }
    
    func createReport() -> Void
    {
        if CEReachabilityManager.isReachable()
        {
            
            PSUserInterfaceManager.sharedInstance.showLoaderWithText(text: "Creating Report")
            PSAPIManager.sharedInstance.createReportForIncidentTypeID(typeID: String(self.incidentTypeID),
                                                                      EmployeeID: String(self.employeeID),
                                                                      success:
            { (dic) in
                    
                PSUserInterfaceManager.sharedInstance.hideLoader()
                print(dic["ReportID"] ?? "")
                self.reportID = dic["ReportID"] as! Int
                PSDataManager.sharedInstance.report?.reportID = dic["ReportID"] as! Int
            } ,
                                                                      failure:
                
            {
                (error:NSError,statusCode:Int) in
                
                PSUserInterfaceManager.sharedInstance.hideLoader()
                if(statusCode==404)
                {
                    PSUserInterfaceManager.showAlert(title: "Creating Report", message: ApiErrorMessage.ErrorOccured)
                }
                else
                {
                    PSUserInterfaceManager.showAlert(title: "Creating Report", message: error.localizedDescription)
                }
                    
            }, errorPopup: true)
        }
        else
        {
            PSUserInterfaceManager.showAlert(title: "Login", message: ApiErrorMessage.NoNetwork)
        }
    }
    
    // MARK: Timer
    
    func startTimer()
    {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(UpdateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func UpdateTimer()
    {
        counter = counter + 1.0
        timeLabel.text = self.timeString(time: Int(counter))
    }
    
    func timeString(time:Int) -> String
    {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        
        return String(format:"%02d:%02d:%02d", hours, minutes, seconds)
    }
}

extension UIImage
{
    enum JPEGQuality: CGFloat
    {
        case lowest  = 0
        case low     = 0.25
        case medium  = 0.5
        case high    = 0.75
        case highest = 1
    }
    
    /// Returns the data for the specified image in JPEG format.
    /// If the image object’s underlying image data has been purged, calling this function forces that data to be reloaded into memory.
    /// - returns: A data object containing the JPEG data, or nil if there was a problem generating the data. This function may return nil if the image has no data or if the underlying CGImageRef contains data in an unsupported bitmap format.
    
    func jpeg(_ quality: JPEGQuality) -> Data?
    {
        return UIImageJPEGRepresentation(self, quality.rawValue)
    }
}
