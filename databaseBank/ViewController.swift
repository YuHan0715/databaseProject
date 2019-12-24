//
//  ViewController.swift
//  databaseBank
//
//  Created by Yuhan_Chan on 2019/12/21.
//  Copyright © 2019 Yuhan_Chan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var logInLabel: UIButton!
    @IBOutlet weak var account: UITextField!
    @IBOutlet weak var password: UITextField!
    var url = "http://140.134.79.128:6627"
    var check:Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        account.delegate = self
        password.delegate = self
        
        account.placeholder = "請輸入帳號" //TextFiled的預設文字
        password.placeholder = "請輸入密碼"
        logInLabel.layer.cornerRadius = 16.5;
        
    }

    @IBAction func click(_ sender: Any) {
        login(user: account.text!, password: password.text!, {(resCheck, resAccount) -> () in
            if resCheck == true {
                Account.account = resAccount
                self.performSegue(withIdentifier: "loginSuccess", sender: nil)
            }
            else {
                self.loginfail()
                self.password.text = ""
            }
        })
    }
    
    func loginfail() {
        let alert = UIAlertController(title: "登入失敗", message: "請重新輸入", preferredStyle: .alert)
        let action = UIAlertAction(title: "確認", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func login(user: String, password: String, _ completion:@escaping(Bool, String) -> ()){
        let parameter: Parameters = [
            "user":user,
            "password":password
        ] //要post的資料
        var resultsCheck:Bool?
        var resultsAccount: String?
        AF.request(url + "/login", method: .post, parameters: parameter, encoding: JSONEncoding.default).responseJSON( completionHandler:{response in
            switch response.result{
            case .success(let value): //取r值
                let json = JSON(value)
                resultsCheck = json["check"].boolValue
                resultsAccount = json["account"].stringValue
//                print(json["check"])
                completion(resultsCheck!, resultsAccount!)
            case .failure(let value):
                let json = JSON(value)
                print(json["status"])
                break
            }
        })
    }
}

