import UIKit
import Alamofire
import SwiftyJSON

class PSReportAPIManager: PSAPIManagerBase
{
    func createReportForIncidentTypeID(typeID: String,
                                       EmployeeID:String,
                                       success:@escaping DefaultArrayResultAPISuccessClosure,
                                       failure:@escaping DefaultAPIFailureClosure,
                                       errorPopup: Bool)
    {
        
        let parameters: [String:Any] =
        [
            "IncidentTypeID":typeID,
            "EmployeeID":EmployeeID,
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
        let EmployeeId = (PSDataManager.sharedInstance.loggedInUser?.employeeId)!
        let parameters: [String:Any] =
            [
                "CompanyId":companyId,
                "EmployeeId":EmployeeId,
                "Filter":"All"
            ]
        
        let route: URL = GETURLfor(route: Route.Notifications.rawValue, parameters: parameters )!
        
        self.getRequestWith(route: route, parameters: [String](), success: success, failure: failure, errorPopup: errorPopup)
    }
    
    func getInfoFor(companyId: String,
                    route: String,
                    success:@escaping DefaultArrayResultAPISuccessClosure,
                    failure:@escaping DefaultAPIFailureClosure,
                    errorPopup: Bool)
    {
        
        let parameters: [String:Any] =
            [
                "CompanyId":companyId,
            ]
        
        let route: URL = GETURLfor(route: route, parameters: parameters )!
        
        self.getRequestWith(route: route, parameters: [String](), success: success, failure: failure, errorPopup: errorPopup)
    }
    
    func uploadImageFor(ReportId: String,
                        Type: String,
                        data: Data,
                        success:@escaping DefaultArrayResultAPISuccessClosure,
                        failure:@escaping DefaultAPIFailureClosure,
                        progress:@escaping DefaultAPIProgressClosure,
                        errorPopup: Bool)
    {
        
        let parameters: [String:Any] =
            [
                "ReportId":ReportId,
                "Type":Type,
            ]
        
        let route: URL = GETURLfor(route: Route.UploadImage.rawValue, parameters: parameters )!
        self.requestWith(endUrl: route.absoluteString, imageData: data ,dataType: Type, parameters: [String:Any](), success: success, failure: failure,uploadProgress: progress ,errorPopup: errorPopup);
        
    }
    
    func updateReportFor(ReportId: String,
                         LocationId: String,
                         Title: String,
                         Details: String,
                         CatagoryId: String,
                         SubCatagory: String,
                         success:@escaping DefaultArrayResultAPISuccessClosure,
                         failure:@escaping DefaultAPIFailureClosure,
                         errorPopup: Bool)
    {
        let parameters: [String:Any] =
            [
                "ReportId":ReportId,
                "LocationId":LocationId,
                "Title":Title,
                "Details":Details,
                "CatagoryId":CatagoryId,
                "SubCatagory":SubCatagory,
            ]
        
        let route: URL = GETURLfor(route: Route.UpdateReport.rawValue, parameters: parameters )!
        
        self.getRequestWith(route: route, parameters: [String](), success: success, failure: failure, errorPopup: errorPopup)
    }
    
    
    func getLocationsFor(companyId: String,
                           success:@escaping DefaultArrayResultAPISuccessClosure,
                           failure:@escaping DefaultAPIFailureClosure,
                           errorPopup: Bool)
    {
        
        let parameters: [String:Any] =
            [
                "CompanyId":companyId,
                ]
        
        let route: URL = GETURLfor(route: Route.LocationsList.rawValue, parameters: parameters )!
        
        self.getRequestWith(route: route, parameters: [String](), success: success, failure: failure, errorPopup: errorPopup)
    }
    
    func getStatictisCount(companyId: String,
                           success:@escaping DefaultArrayResultAPISuccessClosure,
                           failure:@escaping DefaultAPIFailureClosure,
                           errorPopup: Bool)
    {
        
        let parameters: [String:Any] =
            [
                "CompanyId":companyId,
            ]
        
        let route: URL = GETURLfor(route: Route.SummaryStatsCount.rawValue, parameters: parameters )!
        
        self.getRequestWith(route: route, parameters: [String](), success: success, failure: failure, errorPopup: errorPopup)
    }
    
    func getSummaryStatisticsReportsWith(companyId: String,
                                          DateType: String,
                                      IncidentType: String,
                                           success:@escaping DefaultArrayResultAPISuccessClosure,
                                           failure:@escaping DefaultAPIFailureClosure,
                                        errorPopup: Bool)
    {
        
        let parameters: [String:Any] =
            [
                "CompanyId":companyId,
                "DateType":DateType,
                "IncidentType":IncidentType,
            ]
        
        let route: URL = GETURLfor(route: Route.SummaryStatsDetail.rawValue, parameters: parameters )!
        
        self.getRequestWith(route: route, parameters: [String](), success: success, failure: failure, errorPopup: errorPopup)
    }
    
    func listAllEmployeesFor(companyId: String,
                           success:@escaping DefaultArrayResultAPISuccessClosure,
                           failure:@escaping DefaultAPIFailureClosure,
                           errorPopup: Bool)
    {
        
        let parameters: [String:Any] =
            [
                "CompanyId":companyId,
            ]
        
        let route: URL = GETURLfor(route: Route.ListEmployees.rawValue, parameters: parameters )!
        
        self.getRequestWith(route: route, parameters: [String](), success: success, failure: failure, errorPopup: errorPopup)
    }
    
}


