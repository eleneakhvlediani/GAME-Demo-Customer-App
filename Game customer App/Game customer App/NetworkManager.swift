//
//  NetworkManager.swift
//  RubeanTag
//
//  Created by Elene Akhvlediani on 10/6/18.
//  Copyright © 2018 Elene Akhvlediani. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire

class NetworkManager {
    
    static let NetworkManagerSharedInstance = NetworkManager()
    
    private let mainUrl = "https://rubeanpaytxserver299332.rsmartpay.de/rubeangame/api/v1/customer/action"
    
    var user: String?
    var userHmac: String?
    private init(){
        
    }
    private func sendRequest(json: String?,  completionHandler: @escaping (DataResponse<Any>) -> Void){
        
        let url = URL(string: mainUrl)!
        let jsonData = json?.data(using: .utf8, allowLossyConversion: false)!
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        Alamofire.request(request).responseJSON {
            (response) in
            print(response)

            completionHandler(response)
        }
    }
    
//    settings on the server. If the returned status is NOT "0000", simply show a message box as mentioned above.
//    If the returned status is "0000", then store the returned fields user and userhmac in the persistent app store, and remember them in the app, as they will be used in all subsequent API calls. Then go to the Wallet view
    
    
    func register(userName: String, pass: String, callback:@escaping (RegistrationResult?) -> ()){
        let r = UserPayload(action: .register)
        r.user = userName//"tengo@fabrika.ge"
        r.pw = pass//"game1234"
        sendRequest(json: r.toJSONString()) { (response) in
            if let json = response.result.value  as? NSDictionary{
                let obj = Mapper<RegistrationResult>().map(JSONObject: json)
                if let us = obj?.user, let usMac = obj?.userhmac {
                    self.user = us
                    self.userHmac = usMac
                }
                callback(obj)
            }
        }
        
    }
    
    func unRegister(callback:@escaping (Result?) -> ()){
        let r = UserPayload(action: .unregister)
        r.user = self.user
        r.userhmac = self.userHmac
        sendRequest(json: r.toJSONString()) { (response) in
            if let json = response.result.value  as? NSDictionary{
                let obj = Mapper<Result>().map(JSONObject: json)
                callback(obj)
            }
        }
    }
    
    func getUserInfo(callback:@escaping (RegistrationResult?) -> ()){
        let r = UserPayload(action: .getUserInfo)
        r.user = self.user
        r.userhmac = self.userHmac
        sendRequest(json: r.toJSONString()) { (response) in
            if let json = response.result.value  as? NSDictionary{
                let obj = Mapper<RegistrationResult>().map(JSONObject: json)
                callback(obj)
            }
        }
    }
    
    func fetchData(tid: String, callback:@escaping (TransactionResult?) -> ()){
        let r = UserPayload(action: .fetchData)
        r.user = self.user
        r.userhmac = self.userHmac
        r.tid = tid
        sendRequest(json: r.toJSONString()) { (response) in
            if let json = response.result.value  as? NSDictionary{
                let obj = Mapper<TransactionResult>().map(JSONObject: json)
                callback(obj)
            }
        }
    }
    
    func setAuthStatus(tid: String, status: StatusToSet, callback:@escaping (SetAuthStatusResult?) -> ()){
        let r = UserPayload(action: .setAuthStat)
        r.user = self.user
        r.userhmac = self.userHmac
        r.status = status.rawValue
        r.tid = tid
        sendRequest(json: r.toJSONString()) { (response) in
            if let json = response.result.value  as? NSDictionary{
                let obj = Mapper<SetAuthStatusResult>().map(JSONObject: json)
                callback(obj)
            }
        }
    }
    
    func getTransactionStatus(tid: String, callback:@escaping (getTransactionStatusResult?) -> ()){
        let r = UserPayload(action: .getTransactionStatus)
        r.user = self.user
        r.userhmac = self.userHmac
        r.tid = tid
        sendRequest(json: r.toJSONString()) { (response) in
            if let json = response.result.value  as? NSDictionary{
                let obj = Mapper<getTransactionStatusResult>().map(JSONObject: json)
                if obj?.status == "0000" || obj?.status == "0002" {
                    callback(obj)
                }else{
                    self.getTransactionStatus(tid: tid, callback: callback)
                }
            }
        }
    }
    
}

