import UIKit
import Alamofire
import SwiftyJSON

class PSReportAPIManager: PSAPIManagerBase
{
    func createReportForIncidentTypeID(typeID: String,
                                       success:@escaping DefaultArrayResultAPISuccessClosure,
                                       failure:@escaping DefaultAPIFailureClosure,
                                       errorPopup: Bool)
    {
        
        let parameters: [String:Any] =
        [
            "IncidentTypeID":typeID,
        ]
        
        let route: URL = GETURLfor(route: Route.CreateReport.rawValue, parameters: parameters )!
        
        self.getRequestWith(route: route, parameters: [String](), success: success, failure: failure, errorPopup: errorPopup)
    }
    
    func getReportsFor(companyId: String,
                                       success:@escaping DefaultArrayResultAPISuccessClosure,
                                       failure:@escaping DefaultAPIFailureClosure,
                                       errorPopup: Bool)
    {
        
        let parameters: [String:Any] =
            [
                "CompanyId":companyId,
                ]
        
        let route: URL = GETURLfor(route: Route.Reports.rawValue, parameters: parameters )!
        
        self.getRequestWith(route: route, parameters: [String](), success: success, failure: failure, errorPopup: errorPopup)
    }
    
    func getNotificationsFor(companyId: String,
                       success:@escaping DefaultArrayResultAPISuccessClosure,
                       failure:@escaping DefaultAPIFailureClosure,
                       errorPopup: Bool)
    {
        
        let parameters: [String:Any] =
            [
                "CompanyId":companyId,
            ]
        
        let route: URL = GETURLfor(route: Route.Notifications.rawValue, parameters: parameters )!
        
        self.getRequestWith(route: route, parameters: [String](), success: success, failure: failure, errorPopup: errorPopup)
    }
    
}


