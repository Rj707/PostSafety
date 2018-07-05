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
    @objc dynamic var checklistId = 0
    @objc dynamic var checklistName : String?
    @objc dynamic var checklistDetails = [String]()
    @objc dynamic var incidentType = [String]()
    
    public func initWithDictionary(dict:NSDictionary)-> PSChecklist
    {
        let checklist = PSChecklist.init()
        checklist.checklistId = dict["checklistId"] as! Int
        checklist.checklistName = dict["checklistName"] as? String
//        checklist.checklistDetails = (dict["checklistDetails"] as? [String])!
//        checklist.incidentType = (dict["incidentType"] as? [String])!
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

