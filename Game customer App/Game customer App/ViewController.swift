//
//  ViewController.swift
//  Game customer App
//
//  Created by Elene Akhvlediani on 3/27/18.
//  Copyright © 2018 Elene Akhvlediani. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBAction func startSearch(_ sender: UIButton) {
        
        nfcReader.beginSession()
    }
    let nfcReader = NFCReader()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let username = UserDefaults.standard.string(forKey: UserDefaultsKeys.username.rawValue){
            if let password = UserDefaults.standard.string(forKey: UserDefaultsKeys.password.rawValue){
                NetworkManager.NetworkManagerSharedInstance.register(userName: username, pass: password, callback: { (result) in
                    
                    
                })
            }
        }
       
       
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    

}

