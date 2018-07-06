import UIKit

typealias DefaultAPIFailureClosure = (NSError,Int) -> Void
typealias DefaultAPISuccessClosure = (Dictionary<String,AnyObject>) -> Void
typealias DefaultBoolResultAPISuccesClosure = (Bool) -> Void
typealias DefaultArrayResultAPISuccessClosure = (Dictionary<String,AnyObject>) -> Void


protocol APIErrorHandler
{
    func handleErrorFromResponse(response: Dictionary<String,AnyObject>)
    func handleErrorFromERror(error:NSError)
}


class PSAPIManager: NSObject
{
    static let sharedInstance = PSAPIManager()
    
    let authenticationManagerAPI = PSAuthenticationAPIManager()
    let checklistManagerAPI = PSChecklistAPIManager()
    let reportManagerAPI = PSReportAPIManager()
    var serverToken: String?
    {
        get
        {
           return ""
        }
        set
        {
           
        }
    }
}



