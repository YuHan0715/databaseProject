//
//  TransRecord.swift
//  databaseBank
//
//  Created by Yuhan_Chan on 2019/12/22.
//  Copyright © 2019 Yuhan_Chan. All rights reserved.
//

import Foundation
import ObjectMapper
class TransRecord: Mappable {
    
    var transMoney:Int?
    var type: String?
    var AC: String?
    var balance:Int?
    var time:String?
    var no: Int?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        transMoney <- map["transMoney"]
        type <- map["type"]
        AC <- map["AC"]
        balance <- map["balance"]
        time <- map["time"]
        no <- map["no"]
    }
}
