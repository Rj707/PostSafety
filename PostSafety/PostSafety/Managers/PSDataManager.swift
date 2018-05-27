import UIKit

class PSDataManager: NSObject
{
    static let sharedInstance = PSDataManager()
    
    var loggedInUser: PSUser!
    {
        set(user)
        {
            self.loggedInUser = user
            Constants.USER_DEFAULTS.set(user, forKey: "User")
        }
        get
        {
            return self.loggedInUser
        }
    }
    override init()
    {
        super.init()
        loggedInUser = Constants.USER_DEFAULTS.value(forKey: "User") as! PSUser?
    }
    
    func isUserLoggedIn() -> Bool
    {
        return false
    }
}
