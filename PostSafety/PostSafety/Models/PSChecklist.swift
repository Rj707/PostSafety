//
//  PSChecklist.swift
//  PostSafety
//
//  Created by Hafiz Saad on 01/06/2018.
//  Copyright © 2018 Now Tel. All rights reserved.
//

import UIKit

class PSChecklist: NSObject,NSCoding
{
    @objc dynamic var incidentType = 0
    @objc dynamic var typeName : String?
    @objc dynamic var checkList = 0
    @objc dynamic var checklistDetails = NSDictionary()
    
    // Memberwise initializer
    
    init(incidentType: Int, typeName: String, checkList: Int, checklistDetails:NSDictionary)
    {
        self.incidentType = incidentType
        self.typeName = typeName
        self.checkList = checkList
        self.checklistDetails = checklistDetails
    }
    
    // MARK: NSCoding
    
    required convenience init?(coder aDecoder: NSCoder)
    {
        let typeName = aDecoder.decodeObject(forKey: "typeName") as! String
        let checklistDetails = aDecoder.decodeObject(forKey: "checklistDetails") as! NSDictionary
        self.init(incidentType: aDecoder.decodeInteger(forKey: "incidentType"), typeName: typeName, checkList: aDecoder.decodeInteger(forKey: "checkList"), checklistDetails: checklistDetails)
    }
    
    func encode(with aCoder: NSCoder)
    {
        aCoder.encode(incidentType, forKey: "incidentType")
        aCoder.encode(typeName, forKey: "typeName")
        aCoder.encode(checkList, forKey: "checkList")
        aCoder.encode(checklistDetails, forKey: "checklistDetails")
    }
    
    public func initChecklistWithDictionary(dict:NSDictionary)-> PSChecklist
    {
        let checklist = PSChecklist.init(incidentType: 0, typeName: "", checkList: 0, checklistDetails: NSDictionary())
        checklist.incidentType = dict["incidentType1"] as! Int
        checklist.typeName = dict["typeName"] as? String
        checklist.checkList = dict["checkList"] as! Int
        checklist.checklistDetails = (dict["checklistItems"] as? NSDictionary)!
        return checklist
    }
    
}

class PSChecklistDetail: NSObject
{
    @objc dynamic var checklistDetailsId = 0
    @objc dynamic var subChecklistDetailsId = 0
    @objc dynamic var checklistId = 0
    @objc dynamic var name : String?
    @objc dynamic var checklist : String?
    
    public func initWithDictionary(dict:NSDictionary)-> PSChecklistDetail
    {
        let checklistDetail = PSChecklistDetail.init()
        checklistDetail.checklistId = dict["checklistId"] as! Int
        checklistDetail.checklistDetailsId = dict["checklistDetailsId"] as! Int
        checklistDetail.name = dict["name"] as? String
        checklistDetail.checklist = dict["checklist"] as? String
        return checklistDetail
    }
    
}


