//
//  PSPost.swift
//  PostSafety
//
//  Created by Hafiz Saad on 06/09/2018.
//  Copyright © 2018 Now Tel. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

class PSPost: Object
{
    @objc dynamic var employeeID = 0
    @objc dynamic var incidentTypeID = 0
    @objc dynamic var fileData = Data()
    @objc dynamic var type : String?
    @objc dynamic var categoryID = 0
    @objc dynamic var subCategoryID = 0
    @objc dynamic var locationId = 0
    @objc dynamic var isReportPSI = 0
    @objc dynamic var details : String?
    
    public func initWithDictionary(dict:NSDictionary)-> PSPost
    {
        let post = PSPost.init()
        let EmployeeId = PSDataManager.sharedInstance.loggedInUser?.employeeId
        post.employeeID = EmployeeId!
        post.incidentTypeID = dict["IncidentTypeID"] as! Int
        post.type = dict["FileType"] as? String
        
        if post.incidentTypeID == 4
        {
            post.subCategoryID = dict["SubCatagory"] as! Int
            post.isReportPSI = dict["IsPSI"] as! Int
        }
        if post.incidentTypeID != 1
        {
            post.categoryID = dict["CatagoryId"] as! Int
            post.locationId = dict["LocationId"] as! Int
            post.details = dict["Details"] as? String
        }
        
        post.fileData = (dict["data"] as? Data)!
        return post
    }
}

