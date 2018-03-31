
//
//  NFCReaderViewController.swift
//  Game customer App
//
//  Created by Salome Tsiramua on 3/30/18.
//  Copyright © 2018 Elene Akhvlediani. All rights reserved.
//

import UIKit
import LocalAuthentication

class NFCReaderViewController: BaseViewController {

    
    @IBOutlet weak var goodsAmountLabel: UILabel!
    
    @IBOutlet weak var creditsAmountLabel: UILabel!
    
    @IBOutlet weak var touchIDLogo: UIImageView!
    
    @IBOutlet weak var terminalLogo: UIImageView!
    @IBOutlet weak var aboveLabel: UILabel!
  
    
    @IBOutlet weak var pinkButton: UIButton!
    
    @IBOutlet weak var opaqueButton: UIButton!
    
    let nfcReader = NFCReader()
    
    @IBOutlet weak var overTouchIDButton: UIButton!
    
    @IBAction func overTouchIDButtonClickAction(_ sender: UIButton) {
        
        checkTouchID()
    }
    @IBAction func pinkButtonClickAction(_ sender: UIButton) {
        
        nfcReader.beginSession()
        let modalViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoadingViewController")
        modalViewController.modalPresentationStyle = .overCurrentContext
        self.navigationController?.present(modalViewController, animated: true, completion: nil)
    }
    
    @IBAction func opaqueButtonClickAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        opaqueButton.layer.borderColor = UIColor(red: 234/256, green: 234/256, blue: 234/256, alpha: 1).cgColor
        opaqueButton.layer.borderWidth = 1
        
        setHeight()
        setTitle(title: "NFC")
        setBack(hidden: true)
        setRightButton(hidden: false)
        setShadow(hidden: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func checkTouchID() {
        // 1. Create a authentication context
        let authenticationContext = LAContext()
        authenticationContext.localizedFallbackTitle = ""
        var error:NSError?
        
        // 2. Check if the device has a fingerprint sensor
        // If not, show the user an alert view and bail out!
        guard authenticationContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            
            showAlertViewIfNoBiometricSensorHasBeenDetected()
            return
            
        }
        
        // 3. Check the fingerprint
        
        authenticationContext.evaluatePolicy(
            .deviceOwnerAuthenticationWithBiometrics,
            localizedReason: "Put finger on sensor to confirm purchase",
            
            reply: { [unowned self] (success, error) -> Void in
                
                if( success ) {
                    //let tr = self.createTransactionStatus(st: .authorized)
                    
                    //self.setStatus(tr: tr)
                    
                    // Fingerprint recognized
                    // Go to view controller
                    
                }else {
                    
                    // Check if there is an error
                    if let error = error {
                        
                        //    let message = self.errorMessageForLAErrorCode(errorCode: (error as NSError).code)
                        //
                        if error.code == LAError.authenticationFailed.rawValue {
//                            let tr = self.createTransactionStatus(st: .failed)
                            
                           // self.setStatus(tr: tr)
                        }
                        
                    }
                    
                }
                
        })
    }

    func showAlertViewIfNoBiometricSensorHasBeenDetected(){
        
        showAlertWithTitle(title: "Error", message: "Activate TouchID sensor.", okAction: .doNothing)
        
    }
    
    func showAlertViewAfterEvaluatingPolicyWithMessage( message:String ){
        
        showAlertWithTitle(title: "Error", message: message)
        
    }
    
    func showAlertWithTitle( title:String, message:String, okAction:OkButtonActions = OkButtonActions.doNothing) {
        
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
            if okAction == .doNothing {
                
            }else if okAction == .showFail {
                
                //self.showResultView(success: false)
            }else if okAction == .returnToScanNFC{
                
                //self.updateScreenTo(touchID: false)
                
            }
        }
        alertVC.addAction(okAction)
        
        DispatchQueue.main.async() { () -> Void in
            
            self.present(alertVC, animated: true, completion: nil)
            
        }
       
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
