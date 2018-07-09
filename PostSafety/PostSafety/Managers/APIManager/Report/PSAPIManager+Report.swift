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
    
    func getReportsFor(companyId: String,
                                       success:@escaping DefaultArrayResultAPISuccessClosure,
                                       failure:@escaping DefaultAPIFailureClosure,
                                       errorPopup: Bool)
    {
        reportManagerAPI.getReportsFor(companyId: companyId,success: success, failure: failure,errorPopup: errorPopup)
    }
    
    func getNotificationsFor(companyId: String,
                       success:@escaping DefaultArrayResultAPISuccessClosure,
                       failure:@escaping DefaultAPIFailureClosure,
                       errorPopup: Bool)
    {
        reportManagerAPI.getNotificationsFor(companyId: companyId,success: success, failure: failure,errorPopup: errorPopup)
    }
    
    func uploadImageFor(ReportId: String,
                        Type: String,
                        success:@escaping DefaultArrayResultAPISuccessClosure,
                        failure:@escaping DefaultAPIFailureClosure,
                        errorPopup: Bool)
    {
        reportManagerAPI.uploadImageFor(ReportId: ReportId,Type: Type,success: success, failure: failure,errorPopup: errorPopup)
    }
    
}
