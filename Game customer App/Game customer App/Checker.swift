//
//  Checker.swift
//  RubeanTag
//
//  Created by Goga on 10/02/2018.
//  Copyright © 2018 Ertmanetzeuketesebi. All rights reserved.
//

import Foundation
import CoreNFC

class Checker: NSObject {
    
    
    func checkNFC () -> Bool {
        
        return NFCNDEFReaderSession.readingAvailable
        
    }
}
