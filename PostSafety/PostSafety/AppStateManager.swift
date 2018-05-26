import UIKit

class AppStateManager: NSObject
{
    static let sharedInstance = AppStateManager()
    
    var loggedInUser: User!
    
    override init()
    {
        super.init()
    }
    
    func isUserLoggedIn() -> Bool
    {
        return false
    }
}
