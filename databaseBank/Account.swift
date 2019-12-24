//
//  Account.swift
//  databaseBank
//
//  Created by Yuhan_Chan on 2019/12/21.
//  Copyright © 2019 Yuhan_Chan. All rights reserved.
//

import Foundation
import ObjectMapper

class Account: Mappable {
    static var account:String?
    var Pssn:String?
    static var deposit:Int?
    var name:String?
    var Bdate:String?
    var phNumber:String?
    var mail:String?
    var city:String?
    var road:String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        Account.account <- map["account"]
        Pssn <- map["Pssn"]
        Account.deposit <- map["deposit"]
        name <- map["name"]
        Bdate <- map["Bdate"]
        phNumber <- map["phNumber"]
        mail <- map["mail"]
        city <- map["city"]
        road <- map["road"]
    }
}
