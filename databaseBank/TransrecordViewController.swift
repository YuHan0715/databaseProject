//
//  TransrecordViewController.swift
//  databaseBank
//
//  Created by Yuhan_Chan on 2019/12/22.
//  Copyright © 2019 Yuhan_Chan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class TransrecordViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var table: UITableView!
    var url = "http://140.134.79.128:6627"
    var transRecord: Array<TransRecord> = []
    override func viewDidLoad() {
        super.viewDidLoad()
//

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        transRecord = []
        getTransRecord(account: Account.account!, {(res) -> () in
            self.transRecord.append(res)
        //  print(self.transRecord.count)
            self.table.reloadData()
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transRecord.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "transRecordCell", for: indexPath) as UITableViewCell
        let type: String = transRecord[indexPath.row].type!
        if type == "check" {
            cell.textLabel?.text = "餘額查詢 " + "\(transRecord[indexPath.row].balance!)"
        }
        else if type == "transfer" {
            cell.textLabel?.text = "轉出給" + "\(transRecord[indexPath.row].AC!)" + " \(transRecord[indexPath.row].transMoney!)"
        }
        else if type == "deposit" {
            cell.textLabel?.text = "存入" + "\(transRecord[indexPath.row].transMoney!)"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        var status:String?
        if editingStyle == .delete {
            deleteTransRecord(index: indexPath.row, {(res) -> () in
                status = res
                print(status!)
                self.view.reloadInputViews()
                if res == "Success" {
                    self.viewWillAppear(true)
                }
            })
            tableView.reloadRows(at: [indexPath], with: .left)
        }
    }
    
    func getTransRecord(account: String, _ completion:@escaping(TransRecord) -> ()) {
            var transRecordFromPost: Array<TransRecord> = []
            let parameter: Parameters = [
                "account": account
            ]
            AF.request(url + "/getTransRecord", method: .post, parameters: parameter, encoding: JSONEncoding.default).responseJSON(completionHandler: {response in
                switch response.result{
                case .success(let value):
                    let json = JSON(value)
    //                print(json["data"])
    //                print(json["data"]["AC"])
                    for i in 0...json["data"].count - 1{
    //                    print(json["data"][i])
                        transRecordFromPost.append(TransRecord(JSONString: json["data"][i].rawString()!)!)
                        print(json["data"][i])
                        completion(transRecordFromPost[i])
                    }
                case .failure(let value):
                    let json = JSON(value)
                    print(json["status"])
                    print(json["msg"])
                }
            })
            
    }
    
    func deleteTransRecord(index: Int, _ comlpetion: @escaping(String) -> ()) {
        let parameter: Parameters = [
            "no": transRecord[index].no!
        ]
        var res:String?
        print(transRecord[index].no!)
        AF.request(url + "/deleteTransRecord", method: .post, parameters: parameter, encoding: JSONEncoding.default).responseJSON(completionHandler: {respones in
            switch respones.result{
            case .success(let value):
                let json = JSON(value)
                res = json["status"].rawString()
                comlpetion(res!)
            case .failure(let value):
                let json = JSON(value)
                print(json)
            }
        })
    }
    
//    func getTransRecord(account: String, _ completion:@escaping() -> ()){
//        let para
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//    }

}
