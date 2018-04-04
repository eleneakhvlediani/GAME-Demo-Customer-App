//
//  GameWalletViewController.swift
//  Game customer App
//
//  Created by Elene Akhvlediani on 3/30/18.
//  Copyright © 2018 Elene Akhvlediani. All rights reserved.
//

import UIKit

class GameWalletViewController: BaseViewController {

    
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var balance: UILabel!
    
    @IBOutlet weak var scanNFCButton: UIButton!
    
    var result: RegistrationResult?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateInfo()
        setHeight()
        setTitle(title: "GAME WALLET")
        setBack(hidden: true)
        setRightButton(hidden: false)
        setShadow(hidden: false)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    
    override func showNoInternetView(show: Bool) {
        super.showNoInternetView(show: show)
        scanNFCButton.isEnabled = !show
    }
    
    func updateInfo(){
        if let firstName = result?.firstname, let lastName = result?.lastname {
            nameLabel.text = firstName + " " + lastName
        }
        id.text = result?.accountno
        if let credit = result?.creditbalance, let amount = result?.amountbalance {
            balance.text = "\(credit) (£\(amount))"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setTitle(title: "GAME WALLET")
        NetworkManager.NetworkManagerSharedInstance.getUserInfo { res in
            self.result = res
            DispatchQueue.main.async {
                self.updateInfo()
            }
        }
    }
    

}
