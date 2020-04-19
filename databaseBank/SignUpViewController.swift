//
//  SignUpViewController.swift
//  databaseBank
//
//  Created by Yuhan_Chan on 2019/12/22.
//  Copyright © 2019 Yuhan_Chan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SignUpViewController: UIViewController, UITextFieldDelegate {

    var url = "http://140.134.79.128:6627"
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var Pssn: UITextField!
    @IBOutlet weak var phNumber: UITextField!
    @IBOutlet weak var mail: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var sex: UITextField!
    @IBOutlet weak var road: UITextField!
    @IBOutlet weak var BdatePicker: UIDatePicker!
    var Bdate:String?
    @IBOutlet weak var confirm: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        name.delegate = self
        Pssn.delegate = self
        phNumber.delegate = self
        mail.delegate = self
        city.delegate = self
        sex.delegate = self
        road.delegate = self
        
        name.placeholder = "請輸入姓名"
        Pssn.placeholder = "請輸入身分證字號"
        phNumber.placeholder = "請輸入手機號碼"
        mail.placeholder = "請輸入信箱"
        city.placeholder = "請輸入縣市"
        road.placeholder = "請輸入街道"
        sex.placeholder = "請輸入性別"
        
        confirm.layer.cornerRadius = 13
        // Do any additional setup after loading the view.
    }
    

    @IBAction func clickSignUp(_ sender: Any) {
        let BdateValue = DateFormatter()
        BdateValue.dateFormat = "yyyy-MM-dd"
        Bdate = BdateValue.string(from: BdatePicker!.date)
        print(Bdate!)
        print(name.text!)
        print(Pssn.text!)
        print(phNumber.text!)
        print(mail.text!)
        print(city.text!)
        print(road.text!)
        print(sex.text!)
        signUp(name: name.text!, Pssn: Pssn.text!, phNumber: phNumber.text!, mail: mail.text!, city: city.text!, road: road.text!, sex: sex.text!, Bdate: Bdate!,  {(status) -> () in
            print(status)
            if status == "Success" {
                self.signUpSuccess()
            }
            else if status == "Fail" {
                self.signUpSuccess()
            }
        })
    }
    
    func signUpSuccess() {
        let alert = UIAlertController(title: "註冊成功", message: "請重新登入/n帳號為姓名/n密碼預設為身份證字號", preferredStyle: .alert)
        let action = UIAlertAction(title: "確認", style: .default, handler: { (action) -> () in
            self.performSegue(withIdentifier: "signUpSuccess", sender: nil)
        })
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func signUpFail() {
        let alert = UIAlertController(title: "註冊失敗", message: "請重新輸入", preferredStyle: .alert)
        let action = UIAlertAction(title: "確認", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func signUp(name: String, Pssn: String, phNumber:String, mail: String, city: String, road: String, sex: String, Bdate: String, _ completion:@escaping(String) -> ()){
        let parameter: Parameters = [
            "name": name,
            "Pssn":Pssn,
            "Bdate":Bdate,
            "phNumber": phNumber,
            "mail": mail,
            "city": city,
            "road": road,
            "sex": sex
        ] //要post的資料
        var results: String?
        AF.request(url + "/signUp", method: .post, parameters: parameter, encoding: JSONEncoding.default).responseJSON( completionHandler:{response in
            switch response.result{
            case .success(let value): //取值
                let json = JSON(value)
                print(value)
                results = json["status"].stringValue
                completion(results!)
            case .failure(let value):
                let json = JSON(value)
                print(json["status"])
                break
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
