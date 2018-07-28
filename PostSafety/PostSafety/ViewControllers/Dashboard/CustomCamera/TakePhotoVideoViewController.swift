//
//  TakePhotoVideoViewController.swift
//  PostSafety
//
//  Created by Hafiz Saad on 16/05/2018.
//  Copyright © 2018 Now Tel. All rights reserved.
//

import UIKit


class TakePhotoVideoViewController: SwiftyCamViewController, SwiftyCamViewControllerDelegate,PhotoViewControllerDelegate,VideoViewControllerDelegate
{

    @IBOutlet weak var captureButton: SwiftyRecordButton!
    @IBOutlet weak var flipCameraButton: UIButton!
    @IBOutlet weak var flashButton: UIButton!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var timeLabel: UILabel!
    
    var incidentTypeID = 0
    var employeeID = 0
    var reportID = 0
    var checkList = PSChecklist()
    
    var counter = 0.0
    var timer = Timer()
    
    // MARK: Implementation
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        cameraDelegate = self
        maximumVideoDuration = 10.0
        shouldUseDeviceOrientation = true
        allowAutoRotate = true
        audioEnabled = true
        
        let transform = CGAffineTransform(scaleX: 1.5, y: 10.0)
        progressView.transform = transform
        progressView.clipsToBounds = true
        progressView.layer.cornerRadius = progressView.frame.height/2
//        self.progressView.layer.borderWidth=1
//        self.progressView.layer.borderColor = UIColor(red:255/255, green:75/255, blue:1/255, alpha: 1).cgColor
        
        self.employeeID = (PSDataManager.sharedInstance.loggedInUser?.employeeId)!
        if self.incidentTypeID == 0
        {
            self.incidentTypeID = (Global.REPORT?.incidentType)!
        }
        else{}
        self.createReport()
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
    
    // MARK: SwiftyCamViewController
    
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didTake photo: UIImage)
    {
        let newVC = PhotoViewController(image: photo)
        newVC.delegate = self
        self.present(newVC, animated: true, completion: nil)
    }
    
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didBeginRecordingVideo camera: SwiftyCamViewController.CameraSelection)
    {
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
                        self.navigationController?.pushViewController(vc,
                                                                      animated: true)
                    }
                    else
                    {
                        
                        let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
                        let vc = storyboard.instantiateViewController(withIdentifier: "PSEmergencyReportConfirmationViewController") as! PSEmergencyReportConfirmationViewController
                        self.navigationController?.pushViewController(vc,
                                                                      animated: true)
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
            PSUserInterfaceManager.showAlert(title: "Uploading Image", message: ApiErrorMessage.NoNetwork)
        }
        
    }
    
    func sendPhoto(imageData: Data)
    {
        if CEReachabilityManager.isReachable()
        {
            self.progressView.isHidden = false
            PSUserInterfaceManager.sharedInstance.showLoaderWithText(text: "Uploading Image")
            PSAPIManager.sharedInstance.uploadImageFor(ReportId: String(self.reportID), Type: "Image", data:imageData , success:
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
                        self.navigationController?.pushViewController(vc,
                                                                      animated: true)
                    }
                    else
                    {
                        
                        let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
                        let vc = storyboard.instantiateViewController(withIdentifier: "PSEmergencyReportConfirmationViewController") as! PSEmergencyReportConfirmationViewController
                        self.navigationController?.pushViewController(vc,
                                                                      animated: true)
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
            PSUserInterfaceManager.showAlert(title: "Uploading Image", message: ApiErrorMessage.NoNetwork)
        }
    }
    
    // MARK: APIs
    
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
                    Global.REPORT?.reportID = dic["ReportID"] as! Int
            } ,
                                                                      failure:
                
                {
                    (error:NSError,statusCode:Int) in
                    
                    PSUserInterfaceManager.sharedInstance.hideLoader()
                    if(statusCode==404)
                    {
                        PSUserInterfaceManager.showAlert(title: "Login", message: ApiResultFailureMessage.InvalidEmailPassword)
                    }
                    else
                    {
                        
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
