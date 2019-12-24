//
//  MyPageViewController.swift
//  databaseBank
//
//  Created by Yuhan_Chan on 2019/12/23.
//  Copyright © 2019 Yuhan_Chan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class MyPageViewController: UIViewController {

    @IBOutlet weak var accountLable: UILabel!
    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var BdateLabel: UILabel!
    @IBOutlet weak var phNumberLable: UILabel!
    @IBOutlet weak var mailLable: UILabel!
    @IBOutlet weak var cityLable: UILabel!
    @IBOutlet weak var roadLable: UILabel!
    
    let url = "http://140.134.79.128:6627"
    var account: Account?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        getAccountData(account: Account.account!, {(res) -> () in
            self.account = res
            self.reload()
            self.view.reloadInputViews()
        })
        
//        accountLable.text = Account.account!
//        accountLable.sizeToFit()
//        nameLable.text = account?.name!
//        nameLable.sizeToFit()
//        BdateLabel.text = account?.Bdate!
//        BdateLabel.sizeToFit()
//        phNumberLable.text = account?.phNumber!
//        phNumberLable.sizeToFit()
//        mailLable.text = account?.mail!
//        mailLable.sizeToFit()
//        cityLable.text = account?.city!
//        mailLable.sizeToFit()
//        roadLable.text = account?.road!
//        roadLable.sizeToFit()
        
    }
    
    func reload() {
        accountLable.text = Account.account!
        accountLable.sizeToFit()
        nameLable.text = account?.name!
        nameLable.sizeToFit()
        BdateLabel.text = account?.Bdate!
        BdateLabel.sizeToFit()
        phNumberLable.text = account?.phNumber!
        phNumberLable.sizeToFit()
        mailLable.text = account?.mail!
        mailLable.sizeToFit()
        cityLable.text = account?.city!
        cityLable.sizeToFit()
        roadLable.text = account?.road!
        roadLable.sizeToFit()
    }

    func getAccountData(account: String, _ completion: @escaping(Account) -> ()) {
        let parameter: Parameters = [
            "account": Account.account!
        ]
        var data: Account?
        AF.request(url + "/getAccountData", method: .post, parameters: parameter, encoding: JSONEncoding.default).responseJSON(completionHandler: {response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                data =  Account(JSONString: json["data"].rawString()!)
                completion(data!)
            case .failure(let value):
                let json = JSON(value)
                print(json["status"])
                print(json["msg"])
            }
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
