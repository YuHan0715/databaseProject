//
//  TransferViewController.swift
//  databaseBank
//
//  Created by Yuhan_Chan on 2019/12/23.
//  Copyright © 2019 Yuhan_Chan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class TransferViewController: UIViewController, UITextFieldDelegate
{

    let url = "http://140.134.79.128:6627"
    @IBOutlet weak var AC: UITextField!
    @IBOutlet weak var transMoney: UITextField!
    @IBOutlet weak var transferConfirm: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AC.delegate = self
        transMoney.delegate = self

        AC.placeholder = "轉入帳號"
        transMoney.placeholder = "轉入金額"
        transferConfirm.layer.cornerRadius = 15
        // Do any additional setup after loading the view.
    }
    
    func transferToSuccess() {
        let alert = UIAlertController(title: "轉帳成功", message: "可至明細確認", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func transferToFail() {
        let alert = UIAlertController(title: "轉帳失敗", message: "請再嘗試一次", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func transferTo(transMoney: String, AC: String, time: String, _ completion:@escaping(String) -> ()){
        let parameter: Parameters = [
            "account": Account.account!,
            "transMoney": transMoney,
            "AC": AC,
            "deposit": Account.deposit!,
            "time": time
        ]
        AF.request(url + "/transferTo", method: .post, parameters: parameter, encoding: JSONEncoding.default).responseJSON(completionHandler: {response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
                completion(json["status"].rawString()!)
            case .failure(let value):
                let json = JSON(value)
                print(json["status"])
                print(json["msg"])
                break
            }
        })
    }
    
    @IBAction func click(_ sender: Any) {
        transferTo(transMoney: transMoney.text!, AC: AC.text!, time: "2019-12-25", {(res) -> () in
            print(res)
            if(res == "Success") {
                self.transferToSuccess()
            }
            else if(res == "Fail") {
                self.transferToFail()
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
