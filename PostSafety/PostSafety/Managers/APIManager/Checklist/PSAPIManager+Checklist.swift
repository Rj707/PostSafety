import UIKit
import Alamofire
import SwiftyJSON

extension PSAPIManager
{
    func getAllChecklistsForCompanyID(CompanyID:String,
                                            success:@escaping DefaultArrayResultAPISuccessClosure,
                                            failure:@escaping DefaultAPIFailureClosure,
                                            errorPopup: Bool)
    {
        checklistManagerAPI.getAllChecklistsForCompanyID(CompanyID:CompanyID, success: success, failure: failure,errorPopup: errorPopup)
    }
    
    func getChecklistDetailsWith(checkListID:String,
                                     success:@escaping DefaultArrayResultAPISuccessClosure,
                                     failure:@escaping DefaultAPIFailureClosure,
                                  errorPopup: Bool)
    {
        checklistManagerAPI.getChecklistDetailsWith(checkListID:checkListID, success: success, failure: failure,errorPopup: errorPopup)
    }
    
    func getSubCategoriesWith(CatagoryID:String,
                              success:@escaping DefaultArrayResultAPISuccessClosure,
                              failure:@escaping DefaultAPIFailureClosure,
                              errorPopup: Bool)
    {
        checklistManagerAPI.getSubCategoriesWith(CatagoryID: CatagoryID, success: success, failure: failure, errorPopup: errorPopup)
    }
    
    
}
