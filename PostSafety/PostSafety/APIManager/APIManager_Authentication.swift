
import UIKit
import Alamofire
import SwiftyJSON

extension APIManager
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
    
    func updateUserInfo(parameters: Parameters,
                        success:@escaping DefaultArrayResultAPISuccessClosure,
                        failure:@escaping DefaultAPIFailureClosure,
                        errorPopup: Bool)
    {
        authenticationManagerAPI.updateUserInfo(parameters: parameters, success: success, failure: failure,errorPopup: errorPopup)
    }
}
