import UIKit
import Alamofire
import SwiftyJSON

extension PSAPIManager
{
    func createReportForIncidentTypeID(typeID: String,
                                       success:@escaping DefaultArrayResultAPISuccessClosure,
                                       failure:@escaping DefaultAPIFailureClosure,
                                       errorPopup: Bool)
    {
        reportManagerAPI.createReportForIncidentTypeID(typeID: typeID,success: success, failure: failure,errorPopup: errorPopup)
    }
    
}
