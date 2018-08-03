import UIKit
import RealmSwift
class PSDataManager: NSObject
{
    static let sharedInstance = PSDataManager()
    var realm: Realm!
    var report: PSReport?
    var loggedInUser: PSUser?
    var reportId = 0
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
//                self.realm.add(self.loggedInUser!)
                self.realm.add(self.loggedInUser!, update: true)
                print(loggedInUser?.password ?? "")
            }
            
        }

    }
    
    override init()
    {
        super.init()
        
//        loggedInUser = Constants.USER_DEFAULTS.value(forKey: "User") as! PSUser?
        
        self.report = PSReport.init()
        self.reportId = 0
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
