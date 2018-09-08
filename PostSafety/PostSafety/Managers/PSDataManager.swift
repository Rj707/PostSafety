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
    var offlinePostsArray = [PSPost]()
    var offlinePostDictionary = NSMutableDictionary.init()
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
                self.realm.add(self.offlinePost!)
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
        self.offlinePostsArray = [PSPost]()
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
        
//        offlinePost = realm.objects(PSPost.self).first
//        
//        if(offlinePost == nil)
//        {
//            
//        }
//        else
//        {
//            print(offlinePost?.incidentTypeID ?? "")
//            self.offlinePostsArray = Array(realm.objects(PSPost.self))
//        }
        
    }
    
    func removeSubmittedPost()
    {
        if(!(realm != nil))
        {
            realm = try! Realm()
        }
        let result = realm.objects(PSPost.self).first
        try! realm.write
        {
            realm.delete(result!)
        }
        
    }
    
    func isOfflinePostsExist() -> Bool
    {
        if(!(realm != nil))
        {
            realm = try! Realm()
        }
        
        let results = realm.objects(PSPost.self)
        
        if(results.count>0)
        {
            self.offlinePostsArray = Array(realm.objects(PSPost.self))
            return true
        }
        else
        {
            return false
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
