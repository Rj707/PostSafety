//
//  PSLocation.swift
//  PostSafety
//
//  Created by Hafiz Saad on 06/09/2018.
//  Copyright © 2018 Now Tel. All rights reserved.
//

import UIKit

class PSLocation: NSObject
{
    @objc dynamic var branchId = 0
    @objc dynamic var branchName : String?
    @objc dynamic var branchAddress : String?
    @objc dynamic var totalEmployees = 0
    @objc dynamic var companyId = 0
    
    // Memberwise initializer
    
    init(branchId: Int, branchName: String, branchAddress: String, totalEmployees:Int, companyId:Int)
    {
        self.branchId = branchId
        self.branchName = branchName
        self.branchAddress = branchAddress
        self.totalEmployees = totalEmployees
        self.companyId = companyId
    }
    
    required convenience init?(coder aDecoder: NSCoder)
    {
        let branchName = aDecoder.decodeObject(forKey: "branchName") as! String
        let branchAddress = aDecoder.decodeObject(forKey: "branchAddress") as! String
        self.init(branchId: aDecoder.decodeInteger(forKey: "branchId"), branchName: branchName, branchAddress:branchAddress, totalEmployees: aDecoder.decodeInteger(forKey: "totalEmployees"), companyId: aDecoder.decodeInteger(forKey: "companyId"))
    }
    
    func encode(with aCoder: NSCoder)
    {
        aCoder.encode(branchId, forKey: "branchId")
        aCoder.encode(branchName, forKey: "branchName")
        aCoder.encode(branchAddress, forKey: "branchAddress")
        aCoder.encode(totalEmployees, forKey: "totalEmployees")
        aCoder.encode(companyId, forKey: "companyId")
    }
    
}
