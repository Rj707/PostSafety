import UIKit
import RealmSwift

enum PushNotificatinType :Int
{
    case PushNotificatinTypeAlert
    case PushNotificatinTypeAnnouncement
    case PushNotificatinTypeSafety
    case PushNotificatinTypePost
    case PushNotificatinTypeTraining
    case PushNotificatinTypeUndefined
}


class PSDataManager: NSObject
{
    static let sharedInstance = PSDataManager()
    var realm: Realm!
    var report: PSReport?
    var reportId = 0
    var isRememberMe = 0
    var companyLocationsArray = [Any]()
    var isPushNotificationNavigation = 0
    var notificatinType : PushNotificatinType?
    {
        didSet
        {
            self.isPushNotificationNavigation = (self.notificatinType?.rawValue)!
        }
    }
    var loggedInUser: PSUser?
    {
        didSet
        {
            try!  self.realm.write()
            {
                if self.isRememberMe == 0
                {
                    
                }
                else
                {
                    self.realm.add(self.loggedInUser!, update: true)
                    print(loggedInUser?.emailId ?? "")
                }
            }
            
        }
    }
    
    override init()
    {
        super.init()
        
//        loggedInUser = Constants.USER_DEFAULTS.value(forKey: "User") as! PSUser?
        
        self.report = PSReport.init()
        self.reportId = 0
        self.isRememberMe = 0
        self.notificatinType = PushNotificatinType(rawValue: 5)
        self.isPushNotificationNavigation = (self.notificatinType?.rawValue)!
        self.companyLocationsArray = [Any]()
        if(!(realm != nil))
        {
            realm = try! Realm()
        }
        
        loggedInUser = realm.objects(PSUser.self).first
        
        if(loggedInUser == nil)
        {
        }
        else
        {
            print("\(loggedInUser?.emailId ?? "")")
        }
        
    }
    
    func isUserLoggedIn() -> Bool
    {
        if(!(realm != nil))
        {
            realm = try! Realm()
        }
        
        let results = realm.objects(PSUser.self)
        
        if(results.count>0)
        {
            return true
        }
        else
        {
            return false
        }
        
    }
}
