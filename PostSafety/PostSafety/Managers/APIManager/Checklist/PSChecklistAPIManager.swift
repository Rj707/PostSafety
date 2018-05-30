import UIKit
import Alamofire
import SwiftyJSON 

class PSChecklistAPIManager: PSAPIManagerBase
{
    func getAllChecklists(success:@escaping DefaultArrayResultAPISuccessClosure,
                          failure:@escaping DefaultAPIFailureClosure, errorPopup: Bool)
    {
        
        let parameters: [String] =
            [
                
            ]
        
        let route: URL = GETURLforPS(route: Route.Checklist.rawValue, parameters: parameters )!
        
        self.getRequestWith(route: route, parameters: parameters, success: success, failure: failure, errorPopup: errorPopup)
    }
}
