//
//  GameWalletViewController.swift
//  Game customer App
//
//  Created by Elene Akhvlediani on 3/30/18.
//  Copyright © 2018 Elene Akhvlediani. All rights reserved.
//

import UIKit

class GameWalletViewController: UIViewController {

    
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var balance: UILabel!
    
    let nfcReader = NFCReader()
    
    var result: RegistrationResult?
    override func viewDidLoad() {
        super.viewDidLoad()
        if let firstName = result?.firstname, let lastName = result?.lastname {
              nameLabel.text = firstName + " " + lastName
        }
        id.text = result?.accountno
        if let credit = result?.cretitbalance, let amount = result?.amountbalance {
            balance.text = "\(credit) (£\(amount)"
        }
            
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func scanNFC(_ sender: UIButton) {
        
        nfcReader.beginSession()
        
    }
    
    

}
