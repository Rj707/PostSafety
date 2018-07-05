//
//  PSChecklist.swift
//  PostSafety
//
//  Created by Hafiz Saad on 01/06/2018.
//  Copyright © 2018 Now Tel. All rights reserved.
//

import UIKit

class PSChecklist: NSObject
{
    @objc dynamic var incidentType = 0
    @objc dynamic var typeName : String?
    @objc dynamic var checkList = 0
    @objc dynamic var checklistDetails = [NSDictionary]()
    
    public func initChecklistWithDictionary(dict:NSDictionary)-> PSChecklist
    {
        let checklist = PSChecklist.init()
        checklist.incidentType = dict["incidentType"] as! Int
        checklist.typeName = dict["typeName"] as? String
        checklist.checkList = dict["checkList"] as! Int
        checklist.checklistDetails = (dict["checklistItems"] as? [NSDictionary])!
        return checklist
    }
    
}

class PSChecklistDetail: NSObject
{
    @objc dynamic var checklistDetailsId = 0
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

//"incidentType1": 1,
//"typeName": "Emergency",
//"checkList": 10009,
//"checklistItems": {
