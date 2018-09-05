import UIKit
import Alamofire
import SwiftyJSON

extension PSAPIManager
{
    func authenticateUserWith(email: String,password: String,
                          success:@escaping DefaultArrayResultAPISuccessClosure,
                          failure:@escaping DefaultAPIFailureClosure,
                          errorPopup: Bool)
    {
        authenticationManagerAPI.authenticateUserWith(email: email, password: password, success: success, failure: failure,errorPopup: errorPopup)
    }
    
    func userSignupWith(parameters: Parameters,
                        success:@escaping DefaultArrayResultAPISuccessClosure,
                        failure:@escaping DefaultAPIFailureClosure,
                        errorPopup: Bool)
    {
        authenticationManagerAPI.userSignupWith(parameters: parameters, success: success, failure: failure,errorPopup: errorPopup)
    }

    func forgotUserPassword(parameters: Parameters,
                            success:@escaping DefaultArrayResultAPISuccessClosure,
                            failure:@escaping DefaultAPIFailureClosure,
                            errorPopup: Bool)
    {
        authenticationManagerAPI.forgotUserPassword(parameters: parameters, success: success, failure: failure,errorPopup: errorPopup)
    }
    
    func UpdateEmployees(employeeID: String,oldPassword: String,NewPassword: String,
                        success:@escaping DefaultArrayResultAPISuccessClosure,
                        failure:@escaping DefaultAPIFailureClosure,
                        errorPopup: Bool)
    {
        authenticationManagerAPI.UpdateEmployees(employeeID: employeeID,oldPassword: oldPassword,NewPassword: NewPassword, success: success, failure: failure,errorPopup: errorPopup)
    }
    
//    func closeReportWith(ReportId: String,
//                         success:@escaping DefaultArrayResultAPISuccessClosure,
//                         failure:@escaping DefaultAPIFailureClosure, errorPopup: Bool)
//    {
//        authenticationManagerAPI.closeReportWith(ReportId: ReportId, success: success, failure: failure, errorPopup: true)
//    }
    
    func listAllEmployeesFor(companyId: String,
                             success:@escaping DefaultArrayResultAPISuccessClosure,
                             failure:@escaping DefaultAPIFailureClosure,
                             errorPopup: Bool)
    {
        authenticationManagerAPI.listAllEmployeesFor(companyId: companyId, success: success, failure: failure, errorPopup: errorPopup)
    }
    
    func updateDeviceTokenFor(EmployeeID: String,
                              DeviceToken: String,
                             success:@escaping DefaultArrayResultAPISuccessClosure,
                             failure:@escaping DefaultAPIFailureClosure,
                             errorPopup: Bool)
    {
        authenticationManagerAPI.updateDeviceTokenFor(EmployeeID: EmployeeID, DeviceToken: DeviceToken, success: success, failure: failure, errorPopup: errorPopup)
    }
}
