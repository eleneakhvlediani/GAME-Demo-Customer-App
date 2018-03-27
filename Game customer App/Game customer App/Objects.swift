//
//  TransactionResult.swift
//  RubeanTag
//
//  Created by Elene Akhvlediani on 2/10/18.
//  Copyright © 2018 Ertmanetzeuketesebi. All rights reserved.
//

import Foundation
import ObjectMapper

enum Action: String {
    case register = "register"
    case unregister = "unregister"
    case getUserInfo = "getuserinfo"
    case fetchData = "fetchdata"
    case setAuthStat = "setauthstat"
    case getTransactionStatus = "gettransactionstatus"
}

extension Error {
    var code: Int { return (self as NSError).code }
    var domain: String { return (self as NSError).domain }
}

enum StatusToSet : String {
    case success = "0000"
    case denied = "0001"
    case failed = "0002"
    case authorized = "0003"
    
}

enum OkButtonActions {
    case returnToScanNFC
    case doNothing
    case showSuccess
    case showFail
    
}
enum ResponseStatus: String {
    case success = "0000"
    case methodInvalid = "0001"
    case notFound = "0002"
    case markedAsSucceeded = "0006"
    case markedAsFailed = "0007"
    case amountZero = "0008"
    case noArticles = "0009"
    case markedAsDenied = "0060"
    case updateFailed = "0010"
    case insertFailed = "0061"
    case markedAsAuthoorized = "0062"
    
    
    static func getErrorDesc(errorCode:String) -> ResponseErrorDescriprion{
        switch errorCode {
        case ResponseStatus.methodInvalid.rawValue:
            return ResponseErrorDescriprion.methodInvalid
        case ResponseStatus.notFound.rawValue:
            return ResponseErrorDescriprion.notFound
        case ResponseStatus.markedAsSucceeded.rawValue:
            return ResponseErrorDescriprion.markedAsSucceeded
        case ResponseStatus.markedAsFailed.rawValue:
            return ResponseErrorDescriprion.markedAsFailed
        case ResponseStatus.amountZero.rawValue:
            return ResponseErrorDescriprion.amountZero
        case ResponseStatus.noArticles.rawValue:
            return ResponseErrorDescriprion.noArticles
        case ResponseStatus.markedAsDenied.rawValue:
            return ResponseErrorDescriprion.markedAsDenied
        case ResponseStatus.updateFailed.rawValue:
            return ResponseErrorDescriprion.updateFailed
        case ResponseStatus.insertFailed.rawValue:
            return ResponseErrorDescriprion.insertFailed
        case ResponseStatus.markedAsAuthoorized.rawValue:
            return ResponseErrorDescriprion.markedAsAuthoorized
        default:
            return ResponseErrorDescriprion.success
        }
        
    }
    
}
enum ResponseErrorDescriprion :String {
    case success = "Success"
    case methodInvalid = "Request method is invalid (e.g. not POST)"
    case notFound = "Transaction record not found"
    case markedAsSucceeded = "Transaction is already marked as succeeded"
    case markedAsFailed = "Transaction is already marked as failed"
    case amountZero = "Transaction amount is 0.00"
    case noArticles = "Transaction has no articles"
    case markedAsDenied = "Transaction is already marked as denied"
    case updateFailed = "Update of transaction record failed"
    case insertFailed = "Insert of transaction record failed"
    case markedAsAuthoorized = "Transaction is already marked as authorized"
}

enum SetStatusResponseCode:String {
    case success = "0000"
    case invalidMethod = "0001"
    case notFound = "0002"
    case invalidPaymentState = "0003"
    case invalidCardType = "0005"
    case statusAlreadySet = "0006"
    case statusAlreadySet2 = "0007"
    case amountZero = "0008"
   
    case noArticles = "0009"
    case statusAlreadySet3 = "0060"
    case processingFailed = "0010"
    case processingFailed2 = "0061"
    case statusAlreadySet4 = "0062"
   
    static func getErrorDesc(errorCode:String) -> String{
       
        switch errorCode {
        case SetStatusResponseCode.invalidMethod.rawValue:
            return SetStatusErrorMessages.invalidMethod.rawValue
        case SetStatusResponseCode.notFound.rawValue:
            return SetStatusErrorMessages.notFound.rawValue
        case SetStatusResponseCode.invalidPaymentState.rawValue:
            return SetStatusErrorMessages.invalidPaymentState.rawValue
        case SetStatusResponseCode.statusAlreadySet.rawValue, SetStatusResponseCode.statusAlreadySet2.rawValue, SetStatusResponseCode.statusAlreadySet3.rawValue, SetStatusResponseCode.statusAlreadySet4.rawValue:
            return SetStatusErrorMessages.statusAlreadySet.rawValue
        case SetStatusResponseCode.amountZero.rawValue:
            return SetStatusErrorMessages.amountZero.rawValue
        case SetStatusResponseCode.noArticles.rawValue:
            return SetStatusErrorMessages.noArticles.rawValue
        case SetStatusResponseCode.processingFailed.rawValue, SetStatusResponseCode.processingFailed2.rawValue:
            return SetStatusErrorMessages.processingFailed.rawValue
        default:
            return SetStatusErrorMessages.success.rawValue
        }
    }
}

enum SetStatusErrorMessages :String {
    case success = "Success"
    case invalidMethod = "Invalid request method"
    case notFound = "Transaction not found"
    case invalidPaymentState = "Invalid payment state"
    case invalidCardType = "Invalid card type"
    case statusAlreadySet = "Transaction status already set"
   
    case amountZero = "Amount is Zero"
    
    case noArticles = "Transaction has no articles"
    
    case processingFailed = "Transaction processing failed"
   
    
   
}



extension UIColor {
    struct ButtonColors {
        static var blue: UIColor  { return UIColor(red: 41/255, green: 140/255, blue: 169/255, alpha: 1) }
        static var red: UIColor { return UIColor(red: 174/255, green: 50/255, blue: 84/255, alpha: 1) }
    }
}


class UserPayload: Mappable {
    var action: String?
    var apikey: String?
    var user: String?
    var userhmac: String?
    var pw: String?
    var tid: String?
    var status: String?

    
    init(action: Action) {
        self.action = action.rawValue
    }
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        action <-  map["action"]
        apikey <-  map["apikey"]
        user <-  map["user"]
        userhmac <-  map["userhmac"]
        status <-  map["status"]

    }
}


class Result : Mappable {
    
    var action: String?
    var status: String?
    var statusdesc: String?

    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        action <-  map["action"]
        status <-  map["status"]
        statusdesc <-  map["statusdesc"]
    }
}


class ArticleResult : Mappable {
    
    var artid: String?
    var category: String?
    var code: String?
    
    var name: String?
    var name_de: String?
    var pricecredits: Int64?
    
    var priceamount: CGFloat?
    var minage: Int64?
    var checkage: Bool?
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        artid <-  map["artid"]
        category <-  map["category"]
        code <-  map["code"]
        
        name <-  map["name"]
        category <-  map["name_de"]
        pricecredits <-  map["pricecredits"]
        priceamount <-  map["priceamount"]
        minage <-  map["minage"]
        checkage <-  map["checkage"]
    }
}



class TransactionResult: Result {
    var tid: String?
    var category: String?
    var totalcredits: Int64?
    var totalamount: CGFloat?
    var currency: String?
    var cretitbalance: Int64?
    var amountbalance: String?
    var requiredage: Int64?
    var userage: Int64?
    var articles: [ArticleResult]?

    required init?(map: Map) {
        super.init(map: map)
    }
    
    // Mappable
    override func mapping(map: Map) {
        super.mapping(map: map)
        tid <-  map["tid"]
        category <-  map["category"]
        totalcredits <-  map["totalcredits"]
        totalamount <-  map["totalamount"]
        currency <-  map["currency"]
        cretitbalance <-  map["cretitbalance"]
        amountbalance <-  map["amountbalance"]
        requiredage <-  map["requiredage"]
        userage <-  map["userage"]
        articles <-  map["articles"]

    }
}

class RegistrationResult : Result {
    var user: String?
    var userhmac: String?
    var accountno: String?
    var email: String?
    var firstname: String?
    var lastname: String?
    var nickname: String?
    var cretitbalance: String?
    var amountbalance: String?
  
    required init?(map: Map) {
        super.init(map: map)
    }
    
    // Mappable
    override func mapping(map: Map) {
        super.mapping(map: map)
        user <-  map["user"]
        userhmac <-  map["userhmac"]
        accountno <-  map["accountno"]
        email <-  map["email"]
        firstname <-  map["firstname"]
        lastname <-  map["lastname"]
        nickname <-  map["nickname"]
        cretitbalance <-  map["cretitbalance"]
        amountbalance <-   map["amountbalance"]
    }
}

class SetAuthStatusResult : Result {
    
    var tid: String?
    var category: String?
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    // Mappable
    override func mapping(map: Map) {
        super.mapping(map: map)
        tid <-  map["tid"]
        category <-  map["category"]
       
    }
}


class getTransactionStatusResult : SetAuthStatusResult {
    
    var totalcredits: Int64?
    var totalamount: CGFloat?
    var currency: String?
    var cretitbalance: Int64?
    var amountbalance: String?
    var paystatus: String?
    var reason: String?
    var customerauthstat: String?
    var userhmac: String?
    
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    // Mappable
    override func mapping(map: Map) {
        super.mapping(map: map)
        totalcredits <-  map["totalcredits"]
        totalamount <-  map["totalamount"]
        currency <-  map["currency"]
        cretitbalance <-  map["cretitbalance"]
        amountbalance <-  map["amountbalance"]
        paystatus <-  map["paystatus"]
        reason <-  map["reason"]
        customerauthstat <-  map["customerauthstat"]
        userhmac <-  map["userhmac"]

        
    }
}

