//
//  NFCReader.swift
//  Game customer App
//
//  Created by Salome Tsiramua on 3/29/18.
//  Copyright © 2018 Elene Akhvlediani. All rights reserved.
//
import CoreNFC


import Foundation

protocol NFCReaderDelegate {
    func getResult(result: String)
    func alert(title:String, message:String, okAction: OkButtonActions)
}
class NFCReader: NSObject, NFCNDEFReaderSessionDelegate {
    var nfcReaderDelegate: NFCReaderDelegate?
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        
        var result = ""
        for payload in messages[0].records {
            result += String.init(data: payload.payload.advanced(by: 3), encoding: .utf8)! // 1
        }
        nfcReaderDelegate?.getResult(result: result)
//        for message in messages {
//            for record in message.records {
//                print("New Record Found:")
//                print(record.identifier)
//                print(record.payload)
//                print(record.type)
//                print(record.typeNameFormat)
//            }
//        }
    }
    
    
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        print("NFC NDEF Invalidated")
        print("\(error)")
        
        print("The session was invalidated: \(error.localizedDescription)")
        
        if error.code == 204 || error.code == 200 {
            return
        }
        
        NSLog("The session was invalidated: \(error.localizedDescription)")
        
        nfcReaderDelegate?.alert(title: "Could not connect", message: "Hold smartphone Near terminal and Try agan", okAction: .doNothing)
        //self.showAlertWithTitle(title: "Could not connect", message: "Hold smartphone Near terminal and Try agan", okAction: .doNothing)
        
       
    }


    func beginSession() {
        let session = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: true)
        session.begin()
    }
    
    
    
    
    
    
    
    
    
    
    

}
