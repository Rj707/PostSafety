import UIKit
import Realm
import RealmSwift

enum UserType :Int
{
    case UserTypeNormal
    case UserTypeAdmin
}

class PSUser : Object
{
    @objc dynamic var employeeId = 0
    @objc dynamic var employeeSystemId : String?
    @objc dynamic var employeeFullName : String?
    @objc dynamic var title : String?
    @objc dynamic var branchId = 0
    @objc dynamic var companyId = 0
    @objc dynamic var emailId : String?
    @objc dynamic var password : String?
    @objc dynamic var phone : String?
    @objc dynamic var branch : String?
    @objc dynamic var incident : String?
    @objc dynamic var employeeType : String?
    @objc dynamic var passwordChanged = 0
    @objc dynamic var userTypeByRole = 0
    @objc dynamic var isReviewer = 0
    var userType : UserType?
    
    override class func primaryKey() -> String?
    {
        return "employeeId"
    }
    
    public func initWithDictionary(dict:NSDictionary)-> PSUser
    {
        let user = PSUser.init()
        user.employeeId = dict["employeeId"] as! Int
        user.employeeSystemId = dict["employeeSystemId"] as? String
        user.employeeFullName = dict["employeeFullName"] as? String
        user.title = dict["title"] as? String
        user.branchId = dict["branchId"] as! Int
        user.companyId = dict["companyId"] as! Int
        user.emailId = dict["emailId"] as? String
        user.password = dict["password"] as? String
        user.phone = dict["phone"] as? String
        user.branch = dict["branch"] as? String
        user.incident = dict["incident"] as? String
        user.employeeType = dict["employeeType"] as? String
        if user.employeeType == "Admin"
        {
            user.userType = UserType(rawValue: UserType.UserTypeAdmin.rawValue)
            user.userTypeByRole = 1
        }
        else
        {
            user.userType = UserType(rawValue: UserType.UserTypeNormal.rawValue)
            user.userTypeByRole = 0
        }
        
        user.passwordChanged = dict["passwordChanged"] as! Int
        user.isReviewer = dict["isReviewer"] as! Int
        return user
    }
    
}
