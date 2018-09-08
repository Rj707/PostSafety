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
    
    func getReportsForOld(companyId: String,
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
    
    func getInfoFor(companyId: String,
                    route: String,
                    success:@escaping DefaultArrayResultAPISuccessClosure,
                    failure:@escaping DefaultAPIFailureClosure,
                    errorPopup: Bool)
    {
        reportManagerAPI.getInfoFor(companyId: companyId, route: route ,success: success, failure: failure,errorPopup: errorPopup)
    }
    
    func getAllReportsFor(companyId: String,
                    success:@escaping DefaultArrayResultAPISuccessClosure,
                    failure:@escaping DefaultAPIFailureClosure,
                    errorPopup: Bool)
    {
        reportManagerAPI.getAllReportsFor(companyId: companyId, success: success, failure: failure,errorPopup: errorPopup)
    }
    
    func getSharedReportsFor(EmployeeID: String,
                    Type: String,
                    success:@escaping DefaultArrayResultAPISuccessClosure,
                    failure:@escaping DefaultAPIFailureClosure,
                    errorPopup: Bool)
    {
        reportManagerAPI.getSharedReportsFor(EmployeeID: EmployeeID, Type: Type ,success: success, failure: failure,errorPopup: errorPopup)
    }
    
    func uploadImageFor(ReportId: String,
                        Type: String,
                        data: Data,
                        success:@escaping DefaultArrayResultAPISuccessClosure,
                        failure:@escaping DefaultAPIFailureClosure,
                        progress:@escaping DefaultAPIProgressClosure,
                        errorPopup: Bool)
    {
        reportManagerAPI.uploadImageFor(ReportId: ReportId,Type: Type, data:data, success: success, failure: failure,  progress: progress ,errorPopup: errorPopup)
    }
    
    func updateReportFor(ReportId: String,
                         LocationId: String,
                         Title: String,
                         Details: String,
                         CatagoryId: String,
                         SubCatagory: String,
                         IsPSI:Bool,
                         success:@escaping DefaultArrayResultAPISuccessClosure,
                         failure:@escaping DefaultAPIFailureClosure,
                         errorPopup: Bool)
    {
        reportManagerAPI.updateReportFor(ReportId: ReportId,LocationId: LocationId,Title: Title,Details: Details,CatagoryId: CatagoryId,SubCatagory: SubCatagory, IsPSI:IsPSI, success: success, failure: failure,errorPopup: errorPopup)
    }
    
    func getLocationsFor(companyId: String,
                         success:@escaping DefaultArrayResultAPISuccessClosure,
                         failure:@escaping DefaultAPIFailureClosure,
                         errorPopup: Bool)
    {
        reportManagerAPI.getLocationsFor(companyId: companyId, success: success, failure: failure, errorPopup: errorPopup)
    }
    
    func getStatictisCount(companyId: String,
                         success:@escaping DefaultArrayResultAPISuccessClosure,
                         failure:@escaping DefaultAPIFailureClosure,
                         errorPopup: Bool)
    {
        reportManagerAPI.getStatictisCount(companyId: companyId, success: success, failure: failure, errorPopup: errorPopup)
    }
    
    func getSummaryStatisticsReportsWith(companyId: String,
                                         DateType: String,
                                         IncidentType: String,
                                         success:@escaping DefaultArrayResultAPISuccessClosure,
                                         failure:@escaping DefaultAPIFailureClosure,
                                         errorPopup: Bool)
    {
        reportManagerAPI.getSummaryStatisticsReportsWith(companyId: companyId,DateType: DateType,IncidentType: IncidentType, success: success, failure: failure, errorPopup: errorPopup)
    }
    
    func listAllEmployeesFor(companyId: String,
                             success:@escaping DefaultArrayResultAPISuccessClosure,
                             failure:@escaping DefaultAPIFailureClosure,
                             errorPopup: Bool)
    {
        reportManagerAPI.listAllEmployeesFor(companyId: companyId, success: success, failure: failure, errorPopup: errorPopup)
    }
    
    func getReportsFor(CompanyId: String,
                      ReportType: String,
                      ReportedBy: String,
                          Status:Bool,
                       startdate: String,
                         enddate: String,
                         success:@escaping DefaultArrayResultAPISuccessClosure,
                         failure:@escaping DefaultAPIFailureClosure,
                      errorPopup: Bool)
    {
        reportManagerAPI.getReportsFor(CompanyId: CompanyId,ReportType: ReportType,ReportedBy: ReportedBy, Status:Status, startdate: startdate,enddate: enddate,success: success, failure: failure,errorPopup: errorPopup)
    }
    
    func sendReportsWith(ReportID: String,
                         EmployeeID: String,
                         success:@escaping DefaultArrayResultAPISuccessClosure,
                         failure:@escaping DefaultAPIFailureClosure,
                         errorPopup: Bool)
    {
        reportManagerAPI.sendReportsWith(ReportID: ReportID,EmployeeID: EmployeeID,success: success, failure: failure,errorPopup: errorPopup)
    }
    
    func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ())
    {
        URLSession.shared.dataTask(with: url)
        { data, response, error in
            
            completion(data, response, error)
            
        }.resume()
    }
    
    func archiveGetInfoFor(EmployeeId: String,
                           ID: String,
                           route: String,
                           success:@escaping DefaultArrayResultAPISuccessClosure,
                           failure:@escaping DefaultAPIFailureClosure,
                           errorPopup: Bool)
    {
        reportManagerAPI.archiveGetInfoFor(EmployeeId: EmployeeId, ID:ID, route:route, success: success, failure: failure, errorPopup: true)
    }
    
    
    func submitPostOfflineFor(EmployeeId: Int,
                              IncidentTypeID: Int,
                              LocationId: Int,
                              Details: String,
                              CatagoryId: Int,
                              SubCatagory: Int,
                              IsPSI: Bool,
                              FileType: String,
                              data: Data,
                              success:@escaping DefaultArrayResultAPISuccessClosure,
                              failure:@escaping DefaultAPIFailureClosure,
                              progress:@escaping DefaultAPIProgressClosure,
                              errorPopup: Bool)
    {
        reportManagerAPI.submitPostOfflineFor(EmployeeId: EmployeeId, IncidentTypeID: IncidentTypeID,  LocationId: LocationId,  Details: Details,  CatagoryId: CatagoryId,  SubCatagory: SubCatagory, IsPSI: IsPSI, FileType: FileType, data:data, success: success, failure: failure,  progress: progress ,errorPopup: errorPopup)
    }
    
}
