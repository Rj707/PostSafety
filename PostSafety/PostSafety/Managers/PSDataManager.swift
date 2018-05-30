import UIKit
import RealmSwift
class PSDataManager: NSObject
{
    static let sharedInstance = PSDataManager()
    var realm: Realm!
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
                self.realm.add(self.loggedInUser!)
            }
        }

    }
    override init()
    {
        super.init()
        loggedInUser = Constants.USER_DEFAULTS.value(forKey: "User") as! PSUser?
        
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
