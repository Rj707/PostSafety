import UIKit

class PSDataManager: NSObject
{
    static let sharedInstance = PSDataManager()
    
    var loggedInUser: PSUser!
    
    override init()
    {
        super.init()
    }
    
    func isUserLoggedIn() -> Bool
    {
        return false
    }
}
