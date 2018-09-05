//
//  PSReport.swift
//  PostSafety
//
//  Created by Rayyan on 23/06/2018.
//  Copyright © 2018 Now Tel. All rights reserved.
//

import UIKit

class PSReport: NSObject
{
    @objc dynamic var reportID = 0
    @objc dynamic var reportType : String?
    @objc dynamic var reportCategory : String?
    @objc dynamic var reportSubcategory : String?
    @objc dynamic var reportLocation : String?
    @objc dynamic var reportAdditionalDetails : String?
    @objc dynamic var isReportPSI : String?
    @objc dynamic var categoryID = 0
    @objc dynamic var incidentType = 0
    @objc dynamic var subCategoryID = 0
    
    override init()
    {
        super.init()
        
    }
}
