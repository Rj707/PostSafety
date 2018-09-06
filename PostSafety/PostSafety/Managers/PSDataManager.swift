import UIKit
import RealmSwift
class PSDataManager: NSObject
{
    static let sharedInstance = PSDataManager()
    var realm: Realm!
    var report: PSReport?
    var reportId = 0
    var isRememberMe = 0
    var companyLocationsArray = [Any]()
    var offlinePostDictionary = NSMutableDictionary.init()
    var loggedInUser: PSUser?
    {
//        set(user)
//        {
//            self.loggedInUser = user
//            Constants.USER_DEFAULTS.set(user, forKey: "User")
//        }
//        get
//        {
//            return self.loggedInUser
//        }
        didSet
        {
//            Constants.USER_DEFAULTS.set(loggedInUser, forKey: "User")
            
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
