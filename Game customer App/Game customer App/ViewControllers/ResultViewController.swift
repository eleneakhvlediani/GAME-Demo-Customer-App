//
//  ResultViewController.swift
//  Game customer App
//
//  Created by Elene Akhvlediani on 3/31/18.
//  Copyright © 2018 Elene Akhvlediani. All rights reserved.
//

import UIKit

class ResultViewController: BaseViewController {

    @IBOutlet weak var resultImageView: UIImageView!
    @IBOutlet weak var backToWalletButton: UIButton!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var resultDescriptionLabel: UILabel!
    
    @IBOutlet weak var creditInfoView: UIView!
    
    @IBOutlet weak var newCreditsLabel: UILabel!
    @IBOutlet weak var newCreditBalance: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showLogo()
        setHeight()
        setBack(hidden:true)
        setRightButton(hidden: true)
        setShadow(hidden: true)
        showResults(success: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func showResults(success: Bool) {
        resultImageView.isHighlighted = !success
        resultLabel.text = success ? "Thank you" : "Decline"
        resultDescriptionLabel.text = success ? "Your transaction is complete" : "Transaction proccessing failed"
        creditInfoView.isHidden = !success

        
    }
    
    @IBAction func backToWalletClicked(_ sender: UIButton) {
        showResults(success: false)

    }
    
}
