//
//  Server.swift
//  databaseBank
//
//  Created by Yuhan_Chan on 2019/12/21.
//  Copyright © 2019 Yuhan_Chan. All rights reserved.
//

import Foundation
import Alamofire

class  Server {
    
    var url = "http://140.134.79.128:6627"
    
    func Login(_ completion:@escaping() -> ()) {
        let account = "yuhan"
        let password = "0000"
        let parameter: Parameters = [
            "account" : account,
            "password" : password
        ]
        AF.request(url+"/login", parameters:parameter, encoding:JSONEncoding.default).responseJSON(completionHandler:{response in
            
        })
    }
}
