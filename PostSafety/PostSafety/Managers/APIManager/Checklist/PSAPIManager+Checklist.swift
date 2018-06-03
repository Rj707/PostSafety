import UIKit
import Alamofire
import SwiftyJSON

extension PSAPIManager
{
    func getAllChecklists(success:@escaping DefaultArrayResultAPISuccessClosure,
                          failure:@escaping DefaultAPIFailureClosure,
                       errorPopup: Bool)
    {
        checklistManagerAPI.getAllChecklists(success: success, failure: failure,errorPopup: errorPopup)
    }
    
    func getChecklistDetailsWith(checkListID:String,
                                     success:@escaping DefaultArrayResultAPISuccessClosure,
                                     failure:@escaping DefaultAPIFailureClosure,
                                  errorPopup: Bool)
    {
        checklistManagerAPI.getChecklistDetailsWith(checkListID:checkListID, success: success, failure: failure,errorPopup: errorPopup)
    }
    
    
}
