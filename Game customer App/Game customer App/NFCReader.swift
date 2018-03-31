//
//  NFCReader.swift
//  Game customer App
//
//  Created by Salome Tsiramua on 3/29/18.
//  Copyright © 2018 Elene Akhvlediani. All rights reserved.
//
import CoreNFC


import Foundation


class NFCReader: NSObject, NFCNDEFReaderSessionDelegate {

    
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        for message in messages {
            for record in message.records {
                print("New Record Found:")
                print(record.identifier)
                print(record.payload)
                print(record.type)
                print(record.typeNameFormat)
            }
        }
    }
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        print("NFC NDEF Invalidated")
        print("\(error)")
    }


    func beginSession() {
        let session = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: true)
        session.begin()
    }

}
