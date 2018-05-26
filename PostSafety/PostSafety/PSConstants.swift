import UIKit

enum ButtonHeight: Float
{
    case iPhone5  = 42.5
    case iPhone6  = 55.0
    case iPhone6p = 60.0
}

struct Global
{
    static var APP_MANAGER = PSDataManager.sharedInstance
    static var USER        = APP_MANAGER.loggedInUser
}



struct Constants
{
    static let AppName = "PostSafety"
    
    static var CURRENCY_STRING = NSLocalizedString("AED", comment: "")
    static let kUserSessionKey = "userSessionKey"
    
//    static let BaseURL                                        = "http://postsafety.anadeemus.ca"             // Live
    static let BaseURL                                          = "http://postsafety.anadeemus.ca"             // Local
    
    static let NO_INTERNET                                      = NSLocalizedString("No internet connection!", comment: "")
    static let APP_COLOR                                        = UIColor(red: 246/255, green: 97/255, blue: 59/255, alpha: 1.0)
    static let kFONT_WIDTH_FACTOR                               = UIScreen.main.bounds.width / 414
    static let DEFAULT_IPHONE_5_HEIGHT                          = 47
    static let DEFAULT_IPHONE_6_HEIGHT                          = 55
    static let DEFAULT_IPHONE_6P_HEIGHT                         = 60
    static let kWINDOW_FRAME                                    = UIScreen.main.bounds
    static let kSCREEN_SIZE                                     = UIScreen.main.bounds.size
    static let kWINDOW_WIDTH                                    = UIScreen.main.bounds.size.width
    static let kWINDOW_HIEGHT                                   = UIScreen.main.bounds.size.height
    
    static let APP_DELEGATE                                     = UIApplication.shared.delegate as! AppDelegate
    static let UIWINDOW                                         = UIApplication.shared.delegate!.window!
    
    static let USER_DEFAULTS                                    = UserDefaults.standard

    static let PLACEHOLDER_USER                                 = #imageLiteral(resourceName: "menu_profile")
    static let DEFAULT_DROP_DOWN_ANIMATION_TIME                 = 0.15

}

struct ApiErrorMessage
{
    static let NoNetwork = NSLocalizedString("No internet connection!", comment: "")
    static let TimeOut = NSLocalizedString("Connection Timeout.", comment: "")
    static let ErrorOccured = NSLocalizedString("An error occurred. Please try again.", comment: "")
    static let BadRequest = NSLocalizedString("Bad Request.", comment: "")
}

struct ApiResultFailureMessage
{
    static let InvalidEmailPassword = NSLocalizedString("Invalid email or password.", comment: "")
    static let WrongEmailInForgotPassword = NSLocalizedString("User with entered email doesn’t exist.", comment: "")
}

struct FieldsErrorMessage
{
    static let EmailExist = NSLocalizedString("User with entered email address already exists", comment: "")
    static let UsernameExist = NSLocalizedString("This username is already taken, please try another", comment: "")
    static let UsernameValidity = NSLocalizedString("Please enter a valid username", comment: "")
    static let EmailValidity = NSLocalizedString("Please enter a valid email address", comment: "")
    static let ShortPassword = NSLocalizedString("This password is too short", comment: "")
    static let NewOldPasswordMatch = NSLocalizedString("New password cannot be same as old password.", comment: "")
    static let PasswordMisMatch = NSLocalizedString("Passwords do not match.", comment: "")
    static let EmptyPhoneNumber = NSLocalizedString("Please enter your phone number.", comment: "")
    static let EmptyPassword = NSLocalizedString("Please enter your password", comment: "")
}

struct PopupMessage
{
    static let PasswordChanged = NSLocalizedString("An email has been sent to your account with new password.", comment: "")
    static let PasswordChangedSuccess = NSLocalizedString("Password changed successfully.", comment: "")
    static let InternetOffline = NSLocalizedString("Internet connection seems to be offline, Pleas try again.", comment: "")
}
