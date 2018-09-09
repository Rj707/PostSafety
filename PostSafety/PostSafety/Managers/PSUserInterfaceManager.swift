import Foundation
import UIKit
import MapKit
import AVFoundation
import ACProgressHUD_Swift

import Alamofire

class PSUserInterfaceManager:NSObject
{
    static let sharedInstance = PSUserInterfaceManager()
    
    func roundAndFormatFloat(floatToReturn : Float, numDecimalPlaces: Int) -> String
    {
        let formattedNumber = String(format: "%.\(numDecimalPlaces)f", floatToReturn)
        return formattedNumber
    }
    
    static func printFonts()
    {
        for familyName in UIFont.familyNames
        {
            print("\n-- \(familyName) \n")
            for fontName in UIFont.fontNames(forFamilyName: familyName)
            {
                print(fontName)
            }
        }
    }
    
    func topViewController(base: UIViewController? = (Constants.APP_DELEGATE).window?.rootViewController) -> UIViewController?
    {
        if let nav = base as? UINavigationController
        {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController
        {
            if let selected = tab.selectedViewController
            {
                return topViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController
        {
            return topViewController(base: presented)
        }
        return base
    }
    
    
    static func showAlert(title:String?, message:String?)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.view.tintColor = Constants.APP_COLOR
        alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: .default) { _ in })
        PSUserInterfaceManager().topViewController()!.present(alert, animated: true){}
    }
    
    
    static func resizeImage(image: UIImage,  targetSize: CGFloat) -> UIImage
    {
        guard (image.size.width > 1024 || image.size.height > 1024) else
        {
            return image;
        }
        
        var newRect: CGRect = CGRect.zero;
        
        if(image.size.width > image.size.height)
        {
            newRect.size = CGSize(width: targetSize, height: targetSize * (image.size.height / image.size.width))
        }
        else
        {
            newRect.size = CGSize(width: targetSize * (image.size.width / image.size.height), height: targetSize)
        }
        
        UIGraphicsBeginImageContextWithOptions(newRect.size, false, 1.0)
        image.draw(in: newRect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    
    static func thumbnailForVideoAtURL(url: URL) -> UIImage?
    {
        let asset = AVAsset(url: url)
        let assetImageGenerator = AVAssetImageGenerator(asset: asset)
        assetImageGenerator.appliesPreferredTrackTransform=true
        
        var time = asset.duration
        time.value = min(time.value, 2)
        
        do
        {
            let imageRef = try assetImageGenerator.copyCGImage(at: time, actualTime: nil)
            return UIImage(cgImage: imageRef)
        }
        catch
        {
            print("error")
            return nil
        }
    }
    
    static func delay(delay:Double, closure:@escaping ()->())
    {
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
    }
 
    static func getStarImage(_ starNumber: Double, _  rating: Double) -> UIImage
    {
        if round(rating) >= starNumber
        {
            return #imageLiteral(resourceName: "rate_yellowstar")
        }
        else
        {
            return #imageLiteral(resourceName: "rate_whitestar")
        }
    }
    
    static func timeParser(_ str: String) ->String
    {
        if(str != nil)
        {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let dater = dateFormatter.date(from: "2017-08-11 "+str)
            
            dateFormatter.dateFormat = "h:mm a"
            let dateString = dateFormatter.string(from: dater!)
            return dateString.lowercased()
        }
        else
        {
            return ""
        }
        
    }
//
//    static func checkPhoneVerification(completion: @escaping () -> ())
//    {
//        if !AppStateManager.sharedInstance.loggedInUser.PhoneConfirmed
//        {
//            let alert = UIAlertController(title: "Alert", message: Constants.ERROR_VERIFICATION_MISSING, preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "Skip", style: .destructive) { _ in })
//            alert.addAction(UIAlertAction(title: "Verify", style: .default) { _ in
//                completion()
//            })
//
//
//            Utility().topViewController()!.present(alert, animated: true){}
//
//
//        }
//    }
    
    static func dateFormatterWithFormat(_ str: String, withFormat: String) ->String
    {
        if(str != nil)
        {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let dater = dateFormatter.date(from: str)
            
            dateFormatter.dateFormat = withFormat
            let dateString = dateFormatter.string(from: dater!)
            return dateString.lowercased()
        }
        else
        {
            return ""
        }
        
    }
    
    static func getAddressFromPlacemark(placemarks: CLPlacemark) -> String
    {
        return (placemarks.addressDictionary?["FormattedAddressLines"] as! NSArray).componentsJoined(by: ", ")
    }
    
    static func stringToDate (_ str: String) -> Date
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        dateFormatter.timeZone = TimeZone.current
        let date = dateFormatter.date(from: str)
        return date!
    }

    static func getResponse(_ result: Dictionary<String,AnyObject>) -> String
    {
        return result["Message"] as! String
    }
    
    static func getErrorMessage(_ result: Dictionary<String,AnyObject>) -> String
    {
        return (result["Result"] as! Dictionary<String, Any>)["ErrorMessage"] as! String
    }
    
    static func applyBlurEffectToView(toView: UIView) -> UIView?
    {
        if !UIAccessibilityIsReduceTransparencyEnabled()
        {
            toView.backgroundColor = UIColor.clear
            
            let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = toView.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            blurEffectView.alpha = 0.85
            toView.addSubview(blurEffectView)
            
            return blurEffectView
        }
        else
        {
            toView.backgroundColor = UIColor.black
            return nil
        }
    }
    
    func loadUserOnBoarding()
    {
        var navigationController : UINavigationController
        let storyBoard = UIStoryboard.init(name: "Authentication", bundle: Bundle.main)
        let landingPage = storyBoard.instantiateViewController(withIdentifier: "PSLogInViewController")
        navigationController = storyBoard.instantiateViewController(withIdentifier: "PSLogInNavigationController") as! UINavigationController
        navigationController.viewControllers = [landingPage]
        Constants.APP_DELEGATE.window?.rootViewController = navigationController

    }

    func loadHomePage()
    {
        var _ : UINavigationController?
        let storyBoard = UIStoryboard.init(name: "Dashboard", bundle: Bundle.main)

        Constants.APP_DELEGATE.window?.rootViewController = storyBoard.instantiateInitialViewController()
    }
    
    func showLoaderWithText(text:String)
    {
        let progressView = ACProgressHUD.shared
        progressView.progressText = text
        progressView.showHUD()
    }
    
    func hideLoader()
    {
        ACProgressHUD.shared.hideHUD()
    }
    
    func getDateString(fromDateTime dateTime:String, dateTimeFormat:String) -> String
    {
        let dateFormatterGet = DateFormatter()
//        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
//        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        dateFormatterGet.dateFormat = dateTimeFormat
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"
        
        if let date = dateFormatterGet.date(from: dateTime)
        {
            print(dateFormatterPrint.string(from: date))
            return dateFormatterPrint.string(from: date)
        }
        else
        {
            print("There was an error decoding the string")
        }
        
        return ""
    }
    
    func getTimeString(fromDateTime dateTime:String, dateTimeFormat:String) -> String
    {
        let dateFormatterGet = DateFormatter()
//        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatterGet.dateFormat = dateTimeFormat

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "h:mm a"
        
        if let date = dateFormatterGet.date(from: dateTime)
        {
            print(dateFormatterPrint.string(from: date))
            return dateFormatterPrint.string(from: date)
        }
        else
        {
            print("There was an error decoding the string")
        }
        
        return ""
    }
    
    
//    static func markNotificationRead(notificationId: String)
//    {
//        let parameters: Parameters = [
//            "NotificationId": notificationId
//        ]
//        
//        let successClosure: DefaultArrayResultAPISuccessClosure = {
//            (result) in
//            
//            if self.getResponse(result) == "Success"
//            {
//                print("- Marked Notification as read.")
//            }
//            
//        }
//        let failureClosure: DefaultAPIFailureClosure = {
//            (error) in
//            print(error)
//            
//            if(error.code == -1009)
//            {
//                // No internet
//            }
//        }
//        
////        APIManager.sharedInstance.markNotificationRead(parameters: parameters, success:successClosure , failure: failureClosure)
//    }
    

}

