import UIKit

class AppStateManager: NSObject
{
    static let sharedInstance = AppStateManager()
    
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
