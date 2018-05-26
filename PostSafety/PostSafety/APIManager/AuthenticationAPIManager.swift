

import UIKit
import Alamofire
import SwiftyJSON
class AuthenticationAPIManager: APIManagerBase
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
    
    func updateUserInfo(parameters: Parameters,
                           success:@escaping DefaultArrayResultAPISuccessClosure,
                           failure:@escaping DefaultAPIFailureClosure, errorPopup: Bool)
    {
        let route: URL = POSTURLforRoute(route: Route.UpdateProfile.rawValue)!
        
        self.postRequestWith(route: route, parameters: parameters, success: success, failure: failure , errorPopup: errorPopup)
    }
    
    func forgotUserPassword(parameters: Parameters,
                        success:@escaping DefaultArrayResultAPISuccessClosure,
                        failure:@escaping DefaultAPIFailureClosure, errorPopup: Bool)
    {
        let route: URL = POSTURLforRoute(route: Route.ForgotPassword.rawValue)!
        
        self.postRequestWith(route: route, parameters: parameters, success: success, failure: failure, errorPopup: errorPopup)
    }

}
