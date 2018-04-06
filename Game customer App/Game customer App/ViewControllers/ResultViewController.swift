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

    var result: getTransactionStatusResult?
    
    @IBOutlet weak var newCreditsTitle: UILabel!
    
    
    @IBOutlet weak var newCreditBalanceTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showLogo()
        setHeight()
        setBack(hidden:true)
        setRightButton(hidden: true)
        setShadow(hidden: true)
        if result?.status == ResponseStatus.success.rawValue {
            showResults(success: true)
        }else {
            showResults(success: false)
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func showResults(success: Bool) {
        resultImageView.isHighlighted = !success
        resultLabel.text = success ? "Thank you" : "Decline"
        resultDescriptionLabel.text = success ? "Your transaction is complete" : "Transaction proccessing failed"
        creditInfoView.isHidden = !success
        if success {
            if result?.category?.contains("topup") == true{
                newCreditsTitle.text = "New credits added:"
                
            }else{
                newCreditsTitle.text = "Credits debited:"
            }
            newCreditsLabel.text = result?.totalcredits?.description
            
            if result?.userhmac != nil {
                newCreditBalance.text = result?.cretitbalance?.description
            }else{
                newCreditBalance.isHidden = true
                newCreditBalanceTitle.isHidden = true
            }
        }

        
    }
    
    @IBAction func backToWalletClicked(_ sender: UIButton) {
        //self.navigationController?.popViewController(animated: true)
        
       
        for controller in (self.navigationController?.viewControllers)! {
            if controller.isKind(of: GameWalletViewController.self){
                self.navigationController?.popToViewController(controller, animated: true)
                break
            }
        }
        
    }
    
}
