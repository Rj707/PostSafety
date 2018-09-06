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
//    @objc dynamic var fileData : Data
    @objc dynamic var type : String?
    @objc dynamic var categoryID = 0
    @objc dynamic var subCategoryID = 0
    @objc dynamic var locationId = 0
    @objc dynamic var isReportPSI = 0
    @objc dynamic var details : String?
    
    public func initWithDictionary(dict:NSDictionary)-> PSPost
    {
        let post = PSPost.init()
        
        post.employeeID = dict["employeeID"] as! Int
        post.incidentTypeID = dict["incidentTypeID"] as! Int
        post.type = dict["employeeFullName"] as? String
        post.categoryID = dict["categoryID"] as! Int
        post.subCategoryID = dict["subCategoryID"] as! Int
        post.locationId = dict["locationId"] as! Int
        post.isReportPSI = dict["isReportPSI"] as! Int
        post.details = dict["details"] as? String
//        post.data = dict["data"] as? Data
        return post
    }
}
