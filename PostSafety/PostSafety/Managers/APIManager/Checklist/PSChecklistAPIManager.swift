import UIKit
import Alamofire
import SwiftyJSON 

class PSChecklistAPIManager: PSAPIManagerBase
{
    func getAllChecklists(success:@escaping DefaultArrayResultAPISuccessClosure,
                          failure:@escaping DefaultAPIFailureClosure, errorPopup: Bool)
    {
        let CompanyID = PSDataManager.sharedInstance.loggedInUser?.companyId
        let parameters: [String:Any] =
        [
            "CompanyID":CompanyID ?? ""
        ]
        
        let route: URL = GETURLfor(route: Route.IncidentCompany.rawValue, parameters: parameters )!
        
        self.getRequestWith(route: route, parameters: [String](), success: success, failure: failure, errorPopup: errorPopup)
    }
    
    func getChecklistDetailsWith(checkListID:String,
                                     success:@escaping DefaultArrayResultAPISuccessClosure,
                                     failure:@escaping DefaultAPIFailureClosure,
                                  errorPopup: Bool)
    {
        
        let parameters: [String] =
        [
            checkListID
        ]
        
        let route: URL = GETURLforPS(route: Route.SingleChecklist.rawValue, parameters: parameters )!
        
        self.getRequestWith(route: route, parameters: parameters, success: success, failure: failure, errorPopup: errorPopup)
    }
    
    
    func getSubCategoriesWith(CatagoryID:String,
                              success:@escaping DefaultArrayResultAPISuccessClosure,
                              failure:@escaping DefaultAPIFailureClosure,
                              errorPopup: Bool)
    {
        
        let parameters: [String:Any] =
            [
                "CatagoryID":CatagoryID,
            ]
        
        let route: URL = GETURLfor(route: Route.SubCategory.rawValue, parameters: parameters )!
        
        self.getRequestWith(route: route, parameters: [String](), success: success, failure: failure, errorPopup: errorPopup)
    }
}
