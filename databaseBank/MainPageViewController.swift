//
//  MainPageViewController.swift
//  databaseBank
//
//  Created by Yuhan_Chan on 2019/12/22.
//  Copyright © 2019 Yuhan_Chan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class MainPageViewController: UIViewController {

    @IBOutlet weak var hiName: UILabel!
    @IBOutlet weak var balance: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        hiName.text = "Hi! " + Account.account!
        hiName.sizeToFit()
        
//        getMainPageData(account: Account.account!, {(res)->() in
//            self.hiName.text = "Hi! " + Account.account!
//            self.hiName.sizeToFit()
//            self.balance.text = "\(res)"
//            self.balance.sizeToFit()
//            Account.deposit = res
//            self.view.reloadInputViews()
//            })
        // Do any additional setup after loading the view.
    }
    
    func getMainPageData(account: String, _ comletion: @escaping(Int)->()) {
        let url = "http://140.134.79.128:6627"
        let parameter: Parameters = [
            "account":account
        ]
        var despoit: Int?
        AF.request(url + "/getMainPageData", method: .post, parameters: parameter, encoding: JSONEncoding.default).response(completionHandler: {respone in
            switch respone.result {
            case .success(let value):
                let json = JSON(value!)
                despoit = json["balance"].intValue
                print(despoit!)
                comletion(despoit!)
            case .failure(let value):
                let json = JSON(value)
                print(json["status"])
                print(json["msg"])
                break
            }
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getMainPageData(account: Account.account!, {(res)->() in
        self.hiName.text = "Hi! " + Account.account!
        self.hiName.sizeToFit()
        self.balance.text = "\(res)"
        self.balance.sizeToFit()
        Account.deposit = res
        self.view.reloadInputViews()
        })
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
