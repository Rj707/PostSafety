//
//  CameraViewController.swift
//  GMImagePickerSwift
//
//  Created by saadullah on 21/02/2018.
//  Copyright © 2018 saadullah. All rights reserved.
//

import UIKit
import Photos
import MobileCoreServices

public enum AssetPickerType : Int
{
    case gallery
    case attachmentCamera
    case directCamera
    case multipleCaptures
}


class CameraViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate
{

    @IBOutlet var cameraCollectionView : UICollectionView!
    @IBOutlet var reportImageView : UIImageView!
    @IBOutlet var sendButton : UIButton!
    @IBOutlet var camerOverLay : UIView?
    @IBOutlet var galleryButton : UIButton?
    
    var imageManager : PHCachingImageManager?
    var picker : UIImagePickerController?
    var fetchResults : PHFetchResult<AnyObject>!
    
    public var multipleCapturedImagesArray = [UIImage]()
    
//    public var cameraOverlayDelegate: CameraViewControllerDelegate?
    
    public var pickerType: AssetPickerType!
    
    // MARK: - Implementation
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.sendButton.isHidden = true
        // Do any additional setup after loading the view.
//        self.fetchCameraRollAssets()
//        imageManager = PHCachingImageManager()
        self.showImagePicker(for: .camera)
//        perform(#selector(CameraViewController.showImagePicker(forCamera:)), with: nil, afterDelay: 0.1)
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchCameraRollAssets()
    {
        // All album: Sorted by descending creation date.
        let requestOptions = PHImageRequestOptions()
        requestOptions.resizeMode = .exact
        requestOptions.deliveryMode = .highQualityFormat
        requestOptions.isSynchronous = false
        var allFetchResultArray = [AnyHashable]()
        do
        {
            let mediaTypes = [1]
            let options = PHFetchOptions()
            options.predicate = NSPredicate(format: "mediaType in %@", mediaTypes)
            options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
            let assetsFetchResult = PHAsset.fetchAssets(with: options) as? PHFetchResult
            allFetchResultArray.append(assetsFetchResult!)
        }
        fetchResults = allFetchResultArray[0] as! PHFetchResult<AnyObject>
       
        print("")
    }

    // MARK: - UIImagePickerController
    
    @IBAction func showImagePicker(forCamera sender: Any)
    {
        if UIImagePickerController.isSourceTypeAvailable(.camera)
        {
            showImagePicker(for: .camera)
        }
        else
        {
            let _alert = UIAlertView(title: "Alert", message: "No Camera Detected", delegate: nil, cancelButtonTitle: "Dismiss", otherButtonTitles: "")
            _alert.show()
        }
    }
    
    func showImagePicker(for sourceType: UIImagePickerControllerSourceType)
    {
        let imagePickerController = UIImagePickerController()
        imagePickerController.mediaTypes = [kUTTypeMovie as String, kUTTypeImage as String]
        imagePickerController.modalPresentationStyle = .currentContext
        imagePickerController.sourceType = sourceType
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = false
        imagePickerController.modalPresentationStyle = (sourceType == .camera) ? .fullScreen : .popover
        let presentationController: UIPopoverPresentationController? = imagePickerController.popoverPresentationController
        //        presentationController?.barButtonItem = button
        // display popover from the UIBarButtonItem as an anchor
        presentationController?.permittedArrowDirections = .any
        if sourceType == .camera
        {
            // The user wants to use the camera interface. Set up our custom overlay view for the camera.
            imagePickerController.showsCameraControls = false
            /*
             Load the overlay view from the OverlayView nib file. Self is the File's Owner for the nib file, so the overlayView outlet is set to the main view in the nib. Pass that view to the image picker controller to use as its overlay view, and set self's reference to the view to nil.
             */
            Bundle.main.loadNibNamed("CameraOverLay", owner: self, options: nil)
            camerOverLay?.frame = (imagePickerController.cameraOverlayView?.frame)!
            imagePickerController.cameraOverlayView = camerOverLay
            
            //            camerOverLay = nil
        }
        
        self.picker = imagePickerController
        
        let screenSize = UIScreen.main.bounds.size
        let aspectRatio:CGFloat = 4.0/3.0
        let scale = screenSize.height/screenSize.width * aspectRatio
        self.picker?.cameraViewTransform = CGAffineTransform(scaleX: scale, y: scale);
        // we need this for later
        present(self.picker!, animated: true, completion:
            {
                () -> Void in
                //        [_blackOverlayView removeFromSuperview];
                //.. done presenting
//                self.cameraCollectionView.delegate = self
//                self.cameraCollectionView.dataSource = self
                
                self.cameraCollectionView.reloadData()
        })
        
    }
    
    // MARK: - UIImagePickerControllerDelegate
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        self.presentingViewController?.dismiss(animated: true, completion:
        {
            () -> Void in
            //.. done dismissing
        })
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        let tempImage = info[UIImagePickerControllerOriginalImage] as! UIImage
//        case gallery
//        case attachmentCamera
//        case directCamera
//        case multipleCaptures
//        if self.pickerType == .attachmentCamera
//        {
//            self.openPhotoEditorForCamera(image: tempImage,asset: PHAsset(),type:AssetPickerType(rawValue: 1)!)
//        }
//        else if self.pickerType == .directCamera
//        {
//            self.openPhotoEditorForCamera(image: tempImage,asset: PHAsset(),type:AssetPickerType(rawValue: 2)!)
//        }
//        else if self.pickerType == .multipleCaptures
//        {
//            self.galleryButton?.setImage(tempImage, for: .normal)
//            self.multipleCapturedImagesArray.append(tempImage)
//            if self.multipleCapturedImagesArray.count==10
//            {
//                self.openGallery()
//            }
//        }
        self.reportImageView.image = tempImage
        self.dismissCamera()
         self.sendButton.isHidden = false
    }

    // MARK: - CameraOverlay Action Methods
    
    @IBAction func tooglePhotoVideoCamera(sender: UILongPressGestureRecognizer)
    {
        // Dismiss the camera.
        
        if (self.picker?.cameraCaptureMode)!.rawValue == 0
        {
            self.picker?.cameraCaptureMode = UIImagePickerControllerCameraCaptureMode(rawValue: 1)!
        }
        else
        {
            self.picker?.cameraCaptureMode = UIImagePickerControllerCameraCaptureMode(rawValue: 0)!
        }
    }
    
    @IBAction func switchCamera()
    {
        // Dismiss the camera.
        if (self.picker?.cameraDevice)!.rawValue == 0
        {
            self.picker?.cameraDevice = UIImagePickerControllerCameraDevice(rawValue: 1)!
        }
        else
        {
            self.picker?.cameraDevice = UIImagePickerControllerCameraDevice(rawValue: 0)!
        }
    }
    
    @IBAction func dismissCamera()
    {
        // Dismiss the camera.
        self.finishAndUpdate()
    }
    
    @IBAction func captureImage()
    {
        self.picker?.sourceType = .camera
        self.picker?.takePicture()
    }
    
    @IBAction func openGallery()
    {
//        if self.pickerType == .multipleCaptures
//        {
//            self.openPhotoEditorForMultipleCameraCaptures(image: self.multipleCapturedImagesArray[0],asset: PHAsset(),type:AssetPickerType(rawValue: 1)!)
//        }
//        else
//        {
//            self.finishAndUpdate()
//            self.cameraOverlayDelegate?.photoLibraryOpened()
//        }
    }
    
    func finishAndUpdate()
    {
        // Dismiss the image picker.
        self.picker = nil;
        self.dismiss(animated: true, completion:
        {
            () -> Void in
            //.. done dismissing
        })
    }
    
    @IBAction func sendButtonTouched(_ sender: Any)
    {
        var result:[String:String] = (UserDefaults.standard.value(forKey: "dict") as? [String : String])!
       if result["reporttype"] != "Emergency"
       {
        let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SelectCategoryViewController") as! SelectCategoryViewController
        navigationController?.pushViewController(vc,
                                                 animated: true)
        }
       else
       {
        
        let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "QuickSummaryViewController") as! QuickSummaryViewController
        navigationController?.pushViewController(vc,
                                                 animated: true)
        }
        
    }
    //    // MARK: - UICollectionViewDelegate
//
//    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
//    {
//        if pickerType.rawValue == 1 || pickerType.rawValue == 3
//        {
//            self.cameraCollectionView.isHidden =  true
//            return 0
//        }
//        self.cameraCollectionView.isHidden =  false
//        return (fetchResults?.count)!
//    }
//
//    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
//    {
//        cameraCollectionView.register(UINib.init(nibName: "PhotoEditorCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "PhotoEditorCollectionViewCell")
//
//        let cameraCollectionViewCell:PhotoEditorCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoEditorCollectionViewCell", for: indexPath) as! PhotoEditorCollectionViewCell
//
//        let asset : PHAsset = fetchResults![indexPath.item] as! PHAsset
//        imageManager?.requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: PHImageContentMode(rawValue: 2)!, options: nil, resultHandler:
//        {
//            (cameraImage, infoDictionary) in
//            cameraCollectionViewCell.assetImageView.image = cameraImage
//        })
//
//        if asset.mediaType.rawValue == 2
//        {
//            cameraCollectionViewCell.videoImageView.isHidden = false
//        }
//        else
//        {
//            cameraCollectionViewCell.videoImageView.isHidden = true
//        }
//
//        return cameraCollectionViewCell
//    }
//
//    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
//    {
//        let cameraCollectionViewCell:PhotoEditorCollectionViewCell = collectionView.cellForItem(at: indexPath) as! PhotoEditorCollectionViewCell
//        let asset : PHAsset = fetchResults![indexPath.item] as! PHAsset
//        self.presentingViewController?.dismiss(animated: true, completion:
//        {
//            self.cameraOverlayDelegate?.imageDidPicked(image: cameraCollectionViewCell.assetImageView.image!,asset: asset,type:AssetPickerType(rawValue: 0)!)
//        })
//
//    }
//
//    // MARK: - PhotoEditorControlDelegate
//
//    func captureMultipleImages(imagesArray:[UIImage])
//    {
//        if imagesArray.count > 0 {
//            self.galleryButton?.setImage(imagesArray[imagesArray.count-1], for: .normal)
//        }
//        self.multipleCapturedImagesArray = imagesArray
//        self.pickerType = .multipleCaptures
//        self.cameraCollectionView.reloadData()
//    }
//
//    // MARK: - PhotoEditorViewController
//
//    func openPhotoEditorForCamera(image:UIImage, asset:PHAsset, type:AssetPickerType)
//    {
//        let photoEditorVC = PhotoEditorViewController(nibName:"PhotoEditorViewController",bundle: Bundle(for: PhotoEditorViewController.self))
//
////        //PhotoEditorDelegate
////        photoEditor.photoEditorDelegate = self
//        self.cameraOverlayDelegate?.setDelegateForPhotoEditor(photoEditor: photoEditorVC)
//
//        //PhotoEditorControlDelegate
//        photoEditorVC.photoEditorControlDelegate = self
//
//        //The image to be edited
//        photoEditorVC.image = image
//
//        //Stickers that the user will choose from to add on the image
//        //photoEditor.stickers.append(UIImage(named: "sticker" )!)
//
//        //Optional: To hide controls - array of enum control
//        photoEditorVC.hiddenControls = [ .draw, .share]
//
//        if type == .gallery
//        {
//            photoEditorVC.selectedAssetsArray = [asset]
//            photoEditorVC.pickerType = .gallery
//        }
//        else if type == .attachmentCamera
//        {
//            photoEditorVC.hiddenControls = [.draw, .share]
//            photoEditorVC.pickerType = .cameraAttachment
//        }
//        else if type == .directCamera
//        {
//            photoEditorVC.hiddenControls = [.draw, .share]
//            photoEditorVC.pickerType = .cameraDirect
//        }
//
//        //Optional: Colors for drawing and Text, If not set default values will be used
//        photoEditorVC.colors = [.red,.blue,.green]
//
//        //Present the View Controller
//        self.presentedViewController?.present(photoEditorVC, animated: true, completion: nil)
//    }
//
//    func openPhotoEditorForMultipleCameraCaptures(image:UIImage, asset:PHAsset, type:AssetPickerType)
//    {
//        let photoEditorVC = PhotoEditorViewController(nibName:"PhotoEditorViewController",bundle: Bundle(for: PhotoEditorViewController.self))
//
//        //        //PhotoEditorDelegate
//        //        photoEditor.photoEditorDelegate = self
//
//        self.cameraOverlayDelegate?.setDelegateForPhotoEditor(photoEditor: photoEditorVC)
//
//        //PhotoEditorControlDelegate
//        photoEditorVC.photoEditorControlDelegate = self
//
//        //The image to be edited
//        photoEditorVC.image = image
//        photoEditorVC.selectedImagesArray = self.multipleCapturedImagesArray
//        //Stickers that the user will choose from to add on the image
//        //photoEditor.stickers.append(UIImage(named: "sticker" )!)
//
//        //Optional: To hide controls - array of enum control
//        photoEditorVC.hiddenControls = [ .draw, .share]
//
//        photoEditorVC.pickerType = .cameraMultiple
//
//        //Optional: Colors for drawing and Text, If not set default values will be used
//        photoEditorVC.colors = [.red,.blue,.green]
//
//        //Present the View Controller
//        self.presentedViewController?.present(photoEditorVC, animated: true, completion: nil)
//    }
//
}
//
//// MARK: - CameraOverlay Protocol
//
//protocol CameraViewControllerDelegate
//{
//    func imageDidPicked(image:UIImage, asset:PHAsset, type:AssetPickerType)
//    func photoLibraryOpened()
//    func setDelegateForPhotoEditor(photoEditor:PhotoEditorViewController)
//}
