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
        let EmployeeId = PSDataManager.sharedInstance.loggedInUser?.employeeId
        let parameters: [String:Any] =
            [
                "CompanyId":companyId,
                "EmployeeId":EmployeeId ?? "",
            ]
        
        let route: URL = GETURLfor(route: route, parameters: parameters )!
        
        self.getRequestWith(route: route, parameters: [String](), success: success, failure: failure, errorPopup: errorPopup)
    }
    
    func getAllReportsFor(companyId: String,
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
    
    
    func getSharedReportsFor(EmployeeID: String,
                             Type: String,
                             success:@escaping DefaultArrayResultAPISuccessClosure,
                             failure:@escaping DefaultAPIFailureClosure,
                             errorPopup: Bool)
    {
        
        let parameters: [String:Any] =
            [
                "EmployeeID":EmployeeID,
                "Type":Type,
            ]
        
        let route: URL = GETURLfor(route: Route.SharedReports.rawValue, parameters: parameters )!
        
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
                         IsPSI:Bool,
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
                "IsPSI":IsPSI,
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
    
    func closeReportWith(ReportId: String,
                         success:@escaping DefaultArrayResultAPISuccessClosure,
                         failure:@escaping DefaultAPIFailureClosure, errorPopup: Bool)
    {
        
        let parameters: [String] =
            [
                ReportId,
            ]
        
        let route: URL = GETURLforPS(route: Route.CloseReport.rawValue, parameters: parameters )!
        
        self.getRequestWith(route: route, parameters: parameters, success: success, failure: failure, errorPopup: errorPopup)
    }
    
    func getReportsFor(CompanyId: String,
                       ReportType: String,
                       ReportedBy: String,
                       Status:Bool,
                       startdate: String,
                       enddate: String,
                       Location: String,
                       DummyStatus: String,
                       success:@escaping DefaultArrayResultAPISuccessClosure,
                       failure:@escaping DefaultAPIFailureClosure,
                       errorPopup: Bool)
    {
        let employeeID = PSDataManager.sharedInstance.loggedInUser?.employeeId

        var parameters: [String:Any] =
            [
                "CompanyId":employeeID ?? "",
                "ReportType":ReportType,
                "ReportedBy":ReportedBy,
                "Status":Status.description,
                "startdate":startdate,
                "enddate":enddate,
                "Location":Location
            ]
        if DummyStatus == "0"
        {
            parameters["Status"] = ""
        }
        let route: URL = GETURLfor(route: Route.Reports.rawValue, parameters: parameters )!
        
        self.getRequestWith(route: route, parameters: [String](), success: success, failure: failure, errorPopup: errorPopup)
    }
    
    func sendReportsWith(ReportID: String,
                         EmployeeID: String,
                         success:@escaping DefaultArrayResultAPISuccessClosure,
                         failure:@escaping DefaultAPIFailureClosure,
                         errorPopup: Bool)
    {
        
        let parameters: [String:Any] =
            [
                "ReportID":ReportID,
                "Employees":EmployeeID,
            ]
        
        let route: URL = GETURLfor(route: Route.SendReports.rawValue, parameters: parameters )!
        
        self.getRequestWith(route: route, parameters: [String](), success: success, failure: failure, errorPopup: errorPopup)
    }
    
    func createAlertWith(EmployeeId: String,
                         Title: String,
                         Body: String,
                         Employees: String,
                         success:@escaping DefaultArrayResultAPISuccessClosure,
                         failure:@escaping DefaultAPIFailureClosure,
                         errorPopup: Bool)
    {
        
        let parameters: [String:Any] =
            [
                "EmployeeId":EmployeeId,
                "Title":Title,
                "Body":Body,
                "Employees":Employees,
            ]
        
        let route: URL = GETURLfor(route: Route.CreateAlert.rawValue, parameters: parameters )!
        
        self.getRequestWith(route: route, parameters: [String](), success: success, failure: failure, errorPopup: errorPopup)
    }
    
    func archiveGetInfoFor(EmployeeId: String,
                           ID: String,
                           route: String,
                          success:@escaping DefaultArrayResultAPISuccessClosure,
                          failure:@escaping DefaultAPIFailureClosure,
                          errorPopup: Bool)
    {

        let parameters: [String:Any] =
            [
                "EmployeeId":EmployeeId,
                "ID":ID,
            ]

        let route: URL = GETURLfor(route: route, parameters: parameters )!
        
        self.getRequestWith(route: route, parameters: [String](), success: success, failure: failure, errorPopup: errorPopup)
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
        
        let parameters: [String:Any] =
            [
                "EmployeeId":EmployeeId,
                "IncidentTypeID":IncidentTypeID,
                "LocationId":LocationId,
                "Details":Details,
                "CatagoryId":CatagoryId,
                "SubCatagory":SubCatagory,
                "FileType":FileType,
                "IsPSI":IsPSI,
            ]
        
        let route: URL = GETURLfor(route: Route.ReportSingleCall.rawValue, parameters: parameters )!
        
        self.requestWith(endUrl: route.absoluteString, imageData: data ,dataType: FileType, parameters: parameters, success: success, failure: failure,uploadProgress: progress ,errorPopup: errorPopup);
        
    }
    
    func NotifyPostFor(reportID: String,
                         success:@escaping DefaultArrayResultAPISuccessClosure,
                         failure:@escaping DefaultAPIFailureClosure,
                         errorPopup: Bool)
    {
        
        let parameters: [String:Any] =
            [
                "id":reportID,
            ]
        
        let route: URL = GETURLfor(route: Route.NotifyPost.rawValue, parameters: parameters )!
        
        self.getRequestWith(route: route, parameters: [String](), success: success, failure: failure, errorPopup: errorPopup)
    }
    
}


