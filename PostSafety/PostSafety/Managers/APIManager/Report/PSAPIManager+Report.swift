import UIKit
import Alamofire
import SwiftyJSON

extension PSAPIManager
{
    func createReportForIncidentTypeID(typeID: String,
                                       EmployeeID:String,
                                       success:@escaping DefaultArrayResultAPISuccessClosure,
                                       failure:@escaping DefaultAPIFailureClosure,
                                       errorPopup: Bool)
    {
        reportManagerAPI.createReportForIncidentTypeID(typeID: typeID, EmployeeID:EmployeeID , success: success, failure: failure,errorPopup: errorPopup)
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
                        Image: UIImage,
                        success:@escaping DefaultArrayResultAPISuccessClosure,
                        failure:@escaping DefaultAPIFailureClosure,
                        errorPopup: Bool)
    {
        reportManagerAPI.uploadImageFor(ReportId: ReportId,Type: Type, Image:Image, success: success, failure: failure,errorPopup: errorPopup)
    }
    
    func updateReportFor(ReportId: String,
                        LocationId: String,
                        Title: String,
                        Details: String,
                        success:@escaping DefaultArrayResultAPISuccessClosure,
                        failure:@escaping DefaultAPIFailureClosure,
                        errorPopup: Bool)
    {
        reportManagerAPI.updateReportFor(ReportId: ReportId,LocationId: LocationId,Title: Title,Details: Details,success: success, failure: failure,errorPopup: errorPopup)
    }
    
    
//    http://postsafety.anadeemus.ca/api/UpdateReport/?ReportId=10000&LocationId=10008&Title=CriticalIncident&Details=whywhere
    
}
