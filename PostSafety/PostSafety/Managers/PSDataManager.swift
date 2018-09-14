import UIKit
import RealmSwift

enum PushNotificatinType :Int
{
    case PushNotificatinTypeAlert
    case PushNotificatinTypeAnnouncement
    case PushNotificatinTypeSafety
    case PushNotificatinTypePost
    case PushNotificatinTypeTraining
    case PushNotificatinTypePolicies
    case PushNotificatinTypeSharedPost
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

    var offlinePostDictionary = NSMutableDictionary.init()
    var notificatinType : PushNotificatinType?
    var isPushNotificationNavigation = 0

    {
        didSet
        {
            if self.isPushNotificationNavigation == 7
            {
                self.notificatinType = PushNotificatinType.PushNotificatinTypeUndefined
            }
            
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
    var offlinePost: PSPost?
    {
        didSet
        {
            try!  self.realm.write()
            {
                self.realm.add(self.offlinePost!, update: true)
                print(offlinePost?.incidentTypeID ?? "")
            }
        }
    }
    
    override init()
    {
        super.init()
        
        self.report = PSReport.init()
        self.reportId = 0
        self.isRememberMe = 0
        self.notificatinType = PushNotificatinType(rawValue: 7)
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
        
        offlinePost = realm.objects(PSPost.self).first
        
        if(offlinePost == nil)
        {
        }
        else
        {
            print(offlinePost?.incidentTypeID ?? "")
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
