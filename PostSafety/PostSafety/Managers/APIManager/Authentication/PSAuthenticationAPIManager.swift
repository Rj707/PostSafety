import UIKit
import Alamofire
import SwiftyJSON
class PSAuthenticationAPIManager: PSAPIManagerBase
{

    func authenticateUserWith(email: String,password: String,
                          success:@escaping DefaultArrayResultAPISuccessClosure,
                          failure:@escaping DefaultAPIFailureClosure, errorPopup: Bool)
    {
    
        let parameters: [String] =
        [
            email,
            password,
        ]
        
        let route: URL = GETURLforPS(route: Route.Login.rawValue, parameters: parameters )!
        
        self.getRequestWith(route: route, parameters: parameters, success: success, failure: failure, errorPopup: errorPopup)
    }
    
    func userSignupWith(parameters: Parameters,
                              success:@escaping DefaultArrayResultAPISuccessClosure,
                              failure:@escaping DefaultAPIFailureClosure, errorPopup: Bool)
    {
        let route: URL = POSTURLforRoute(route: Route.Register.rawValue)!
        
        self.postRequestWith(route: route, parameters: parameters, success: success, failure: failure, errorPopup: errorPopup)
    }
    
    func UpdateEmployees(employeeID: String,oldPassword: String,NewPassword: String,
                         success:@escaping DefaultArrayResultAPISuccessClosure,
                         failure:@escaping DefaultAPIFailureClosure,
                         errorPopup: Bool)
    {
        let parameters: [String] =
            [
                employeeID,
                oldPassword,
                NewPassword
            ]
        
        let route: URL = GETURLforPS(route: Route.UpdateEmployees.rawValue, parameters: parameters )!
        self.getRequestWith(route: route, parameters: parameters, success: success, failure: failure , errorPopup: errorPopup)
    }
    
    func forgotUserPassword(parameters: Parameters,
                        success:@escaping DefaultArrayResultAPISuccessClosure,
                        failure:@escaping DefaultAPIFailureClosure, errorPopup: Bool)
    {
        let route: URL = POSTURLforRoute(route: Route.UpdateEmployees.rawValue)!
        
        self.postRequestWith(route: route, parameters: parameters, success: success, failure: failure, errorPopup: errorPopup)
    }
    
//    func closeReportWith(ReportId: String,
//                      success:@escaping DefaultArrayResultAPISuccessClosure,
//                      failure:@escaping DefaultAPIFailureClosure, errorPopup: Bool)
//    {
//        
//        let parameters: [String] =
//            [
//                ReportId,
//            ]
//        
//        let route: URL = GETURLforPS(route: Route.CloseReport.rawValue, parameters: parameters )!
//        
//        self.getRequestWith(route: route, parameters: parameters, success: success, failure: failure, errorPopup: errorPopup)
//    }
    
    func listAllEmployeesFor(companyId: String,
                             success:@escaping DefaultArrayResultAPISuccessClosure,
                             failure:@escaping DefaultAPIFailureClosure,
                             errorPopup: Bool)
    {
        
        let parameters: [String:Any] =
            [
                "CompanyId":companyId,
            ]
        
        let route: URL = GETURLfor(route: Route.ListEmployees.rawValue, parameters: parameters )!
        
        self.getRequestWith(route: route, parameters: [String](), success: success, failure: failure, errorPopup: errorPopup)
    }
    
    func updateDeviceTokenFor(EmployeeID: String,
                              DeviceToken: String,
                              success:@escaping DefaultArrayResultAPISuccessClosure,
                              failure:@escaping DefaultAPIFailureClosure,
                              errorPopup: Bool)
    {
        let parameters: [String:Any] =
            [
                "EmployeeID":EmployeeID,
                "DeviceToken":DeviceToken,
            ]
        
        let route: URL = GETURLfor(route: Route.UpdateDeviceToken.rawValue, parameters: parameters )!
        
        self.getRequestWith(route: route, parameters: [String](), success: success, failure: failure, errorPopup: errorPopup)
    }

}
